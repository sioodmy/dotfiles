#!/bin/sh

total_todo=$(todo | wc -l)
todo_raw_done=$(todo raw done | sed 's/^/      ◉ /' | sed -z 's/\n/\\n/g')
todo_raw_undone=$(todo raw todo | sed 's/^/     ◉ /' | sed -z 's/\n/\\n/g')
done=$(todo raw done | wc -l)
undone=$(todo raw todo | wc -l)
tooltip=$(todo)

left="$done/$total_todo"

header="<b>todo</b>\\n\\n"
tooltip=""
if [[ $total_todo -gt 0 ]]; then
	if [[ $undone -gt 0 ]]; then
		export tooltip="${header}👷 Today, you need to do:\\n\\n $(echo ${todo_raw_undone})\\n\\n✅ You have already done:\\n\\n $(echo ${todo_raw_done})"
		export output=" 📝 \\n ${left}"
	else
		export tooltip="${header}✅ All done!\\n🥤 Remember to stay hydrated!"
		export output=" 🎉 \\n ${left}"
	fi
else
	export tooltip=""
	export output=""
fi

printf '{"text": "%s", "tooltip": "%s" }' "${output}" "${tooltip}"
