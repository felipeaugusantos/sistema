object fraGridBandedFrm: TfraGridBandedFrm
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object cxConsulta: TcxGrid
    Left = 0
    Top = 41
    Width = 451
    Height = 116
    Align = alClient
    BorderStyle = cxcbsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 45
    ExplicitHeight = 146
    object cxConsultaView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      Bands = <
        item
        end>
    end
    object cxConsultaNivel: TcxGridLevel
      GridView = cxConsultaView
    end
  end
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    Visible = False
    DesignSize = (
      451
      41)
    object imgSupEsq: TImage
      Left = 0
      Top = 0
      Width = 10
      Height = 10
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        0000434944415428538DCDD10900200845516B09F7DFCE2DEC8552560A9D9F84
        4BDA44841ECC6C43B7275A0D8E8C101BEC7C05E3396D90DC8E66AEBE4253551F
        331FCB4B4403FAA107AB2DD58AAA0000000049454E44AE426082}
      Visible = False
    end
    object imgSupDir: TImage
      Left = 441
      Top = 0
      Width = 10
      Height = 10
      Anchors = [akTop, akRight]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00004349444154285363FCFFFF3F0318BC7CF912C240064C509A81415C5C1CCA
        420208DD70806C0C42371C201B83451A08E02AB04BC3014E698801589C860CC8
        351C04181800F6D40F93759654D70000000049454E44AE426082}
      Visible = False
      ExplicitLeft = 576
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 157
    Width = 451
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    Visible = False
    ExplicitTop = 187
    DesignSize = (
      451
      10)
    object imgInfEsq: TImage
      Left = 0
      Top = 0
      Width = 10
      Height = 10
      Anchors = [akLeft, akBottom]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00003649444154285363FCFFFF3F036EC004A5710042D22F5FBE8432B101906E
        3C2A88B31B970108DD5855A0180E5481A6088BDD08150C0C001839162E94ECBA
        750000000049454E44AE426082}
    end
    object imgInfDir: TImage
      Left = 441
      Top = 0
      Width = 10
      Height = 10
      Anchors = [akRight, akBottom]
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000000A
        0000000A0802000000025058EA000000017352474200AECE1CE9000000046741
        4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
        00003749444154285363FCFFFF3F036EC004A571000AA45FBE7C89531A280724
        C9321CA21508B048C3E58000C5DFC8121080D08D29C7C0C00000A454166F77F2
        649E0000000049454E44AE426082}
      ExplicitLeft = 576
    end
  end
  object pnlLegendas: TPanel
    Left = 0
    Top = 238
    Width = 451
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlLegendas'
    Color = 16770261
    ParentBackground = False
    ShowCaption = False
    TabOrder = 3
    Visible = False
  end
  object pnlRodapeGrid: TPanel
    Left = 0
    Top = 197
    Width = 451
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlLegendas'
    Color = 16770261
    ParentBackground = False
    ShowCaption = False
    TabOrder = 4
    Visible = False
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 279
    Width = 451
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 5
    Visible = False
    object FlwBotoes: TFlowPanel
      Left = 2
      Top = 2
      Width = 447
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
  end
  object pnlMensagemRodape: TPanel
    Left = 0
    Top = 167
    Width = 451
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Mensagem rodap'#233
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    Visible = False
    ExplicitTop = 156
  end
  object tmrRefreshDados: TTimer
    Enabled = False
    Interval = 5000000
    OnTimer = tmrRefreshDadosTimer
    Left = 120
    Top = 128
  end
end
