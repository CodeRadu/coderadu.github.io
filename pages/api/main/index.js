export default function (req, res) {
  res.status(500).json({ status: 'Error', error: 'No action provided' });
}
