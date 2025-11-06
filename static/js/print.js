const states = new WeakMap();
const openAll = () =>
  document.querySelectorAll("details").forEach((d) => {
    states.set(d, d.hasAttribute("open"));
    d.setAttribute("open", "");
  });
const restore = () =>
  document.querySelectorAll("details").forEach((d) => {
    if (!states.get(d)) d.removeAttribute("open");
  });
addEventListener("beforeprint", openAll);
addEventListener("afterprint", restore);
