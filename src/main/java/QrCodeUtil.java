/*
 * Copyright (c) 2020, Peter Abeles. All Rights Reserved.
 *
 * This file is part of BoofCV (http://boofcv.org).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import boofcv.abst.fiducial.QrCodeDetector;
import boofcv.alg.fiducial.qrcode.QrCode;
import boofcv.alg.fiducial.qrcode.QrCodeEncoder;
import boofcv.alg.fiducial.qrcode.QrCodeGeneratorImage;
import boofcv.concurrency.BoofConcurrency;
import boofcv.factory.fiducial.FactoryFiducial;
import boofcv.io.image.ConvertBufferedImage;
import boofcv.io.image.UtilImageIO;
import boofcv.struct.image.GrayU8;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class QrCodeUtil {
	public static void main( String[] args ) throws Exception {
		BoofConcurrency.USE_CONCURRENT = false;

		switch(args[0]) {
			case "render":
				render(args[1]);
				break;
			case "detect":
				detect(args[1]);
				break;
		}
	}

	public static void render(String filename) throws Exception {
		String message = new String(Files.readAllBytes(Paths.get("input.dat")));
		QrCode qr = new QrCodeEncoder().
				addAutomatic(message).fixate();

		QrCodeGeneratorImage render = new QrCodeGeneratorImage(20);
		render.render(qr);

		UtilImageIO.saveImage(render.getGray(), filename);
	}

	public static void detect(String filename) throws Exception {
		BufferedImage input = ImageIO.read(new File(filename));
		GrayU8 gray = ConvertBufferedImage.convertFrom(input, (GrayU8) null);

		QrCodeDetector<GrayU8> detector = FactoryFiducial.qrcode(null, GrayU8.class);
		detector.process(gray);

		List<QrCode> detections = detector.getDetections();
		String message = detections.isEmpty() ? "" : detections.get(0).message;
		try (PrintWriter out = new PrintWriter("output.dat")) {
			out.print(message);
		}
	}
}
