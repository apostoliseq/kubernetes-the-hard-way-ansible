make use of handlers/

Mallon h lush sthn antikatastash variables se .j2 files
- name: Deploy Umbrella chart {{ umbrella_chart_version }}
    kubernetes.core.helm:
    name: "{{ umbrella_app_name }}"
    namespace: default
    create_namespace: yes
    chart_ref: "{{ repo_name }}/{{ umbrella_app_name }}"
    chart_version: "{{ umbrella_chart_version }}"
    update_repo_cache: yes
    wait: yes
    wait_timeout: "30m"
    values: "{{ (lookup('template', 'templates/node/umbrella/umbrella-values.j2') | from_yaml) | combine((lookup('file', 'templates/node/umbrella/node-profiles/' + node_profile + '.yaml') | from_yaml), recursive=True) }}"

file structure:
    - templates/umbrella/node-profiles/high|low|standard .yaml
    - templates/umbrella/umbrella-values.j2