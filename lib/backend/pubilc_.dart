final url = "https://48ee-2403-6200-8858-f0-e01f-fc44-4590-aeb7.ap.ngrok.io";
const productsGraphQL = """
query ExampleQuery {
  notifications {
    _id
  }
}
""";
const changMyDutyGraphQL = r"""
query Notifications($filter: JSON) {
  notifications(filter: $filter) {
    _id
    approve_by {
      frist_name
      last_name
    }
    user {
      _id,
      frist_name
      last_name
    }
    fields
    noift
  }
}""";

const sendLeave = r"""mutation CreateLeave($input: CreateLeaveInput!) {
  createLeave(input: $input)
}""";

const nameAll = r"""
query Users {
  users {
    _id
    frist_name
    last_name
    actor
    groups {
      name_group
    }
  }
}
""";
