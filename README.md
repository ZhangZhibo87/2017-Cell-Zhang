# 2017-Cell-Zhang
In this project are five files:

1.ipeaks.m is a function we used to detect notable peaks in single-cell Nuc.RelA time series.

2.ipeaksNarrow.m is a function based on ipeaks.m to find more rational peak minimums.

3.WaveformProperties.m is a function to identify oscillatory period and the other four waveform characteristics(i.e. rest time, rise time, decay time and amplitude).

4.sample_data.mat saves 60 single-cell Nuc.RelA trajectories observed within 10 hours after 10mu/mL alpha-factor stimulation(see Figure S3).

5.main.m is a script for demonstrating how we find peaks and calculate waveform properties.


Run the script "main.m" and it will show detected peaks and the histograms of 5 waveform properties.
