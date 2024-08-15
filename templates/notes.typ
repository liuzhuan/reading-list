#let notes(doc) = {
    set page(
        paper: "a4",
        margin: (
            x: 4em,
            y: 3em,
        ),
        numbering: "1"
    )

    outline(
        title: "目录",
        indent: auto
    )

    set text(11pt, font: "Songti SC")

    show heading.where(level: 1): set heading(
        numbering: "第 1 章"
    )

    show heading.where(level: 2): set heading(
        numbering: "1.1"
    )

    show heading.where(level: 3): set heading(
        numbering: "1.1"
    )

    [#doc]
}
