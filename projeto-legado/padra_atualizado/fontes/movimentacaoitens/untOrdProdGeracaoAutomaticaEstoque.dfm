inherited frmOrdProdGeracaoAutomaticaEstoque: TfrmOrdProdGeracaoAutomaticaEstoque
  Width = 1020
  Height = 630
  Caption = 'Ordem de Produ'#231#227'o - Gera'#231#227'o autom'#225'tica por an'#225'lise de estoque'
  StyleElements = [seFont, seBorder]
  ExplicitWidth = 1020
  ExplicitHeight = 630
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 557
    Width = 1014
    TabOrder = 5
    ExplicitTop = 557
    ExplicitWidth = 1014
    inherited FlwBotoes: TFlowPanel
      Width = 1010
      ExplicitWidth = 1010
      object btnCalcular: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 230
        Height = 22
        Caption = '[F1] Calcular'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000090000
          000E0000000F0000000F0000000F0000000F0000001000000010000000100000
          0010000000100000001000000010000000100000000F0000000A815A4DC1B47D
          6BFFB37C6CFFB37C6BFFB37C6BFFB37C6AFFB37B6AFFB37B6AFFB27B69FFB37B
          69FF194FA6FF194DA5FF184BA4FF184AA3FF1849A2FF113374C1B57F6FFFF8F2
          EFFFF8F2EEFFF8F2EEFFF8F2EEFFCFA89CFFF7F2EEFFF8F2EEFFF7F2EEFFF8F2
          EEFF1D58ADFF9EDAF7FF59BAEFFF59BAF0FF58BAF0FF194FA6FFB68272FFF9F3
          EFFFF8F0ECFFF7F0ECFFF8F0ECFFC69A8DFFF8F1ECFFF7F0ECFFF7F0EBFFF7F0
          EBFF1D58ADFF9EDAF7FF73C9F3FF73C9F4FF72C9F4FF194FA6FFB88575FFF9F3
          F1FFF8F1EEFFF8F1EEFFF8F1EDFFC79C8EFFF8F1EEFFF8F1EDFFF8F1EDFFF8F1
          EDFF2060B4FFA2DDF8FFA2DEF8FFA2DDF8FFA2DDF7FF1D57ADFF1F5BB0FF1F59
          AFFF1E57AEFF1E56ADFF1E55ACFF1C53ABFFC89D8FFFC79D8FFFC89D8FFFC79D
          8FFF2268B8FF2266B7FF2165B6FF2163B5FF2062B4FF1F60B4FF2365B6FFA8DE
          F8FF66C2F1FF66C2F2FF65C2F2FF1F5BB0FFF9F3F0FFF8F3EFFFF9F2F0FFF9F3
          F0FFC89E90FFF8F3EFFFF9F3EFFFF8F3EFFFF9F5F2FFB88676FF2365B6FFA8DE
          F8FF80CFF4FF80CFF5FF7FCFF5FF1F5BB0FFF9F4F2FFFAF4F1FFF9F4F1FFFAF4
          F1FFC9A092FFF9F4F1FFF9F4F1FFF9F4F0FFFAF5F2FFBA8979FF276DBCFFACE1
          F9FFACE2F9FFACE1F9FFACE1F8FF2464B6FFFAF5F3FFFBF5F3FFFAF5F3FFFAF5
          F2FFCAA193FFFAF5F2FFFAF5F2FFFAF4F2FFFBF7F4FFBB8C7DFF2975C0FF2973
          BFFF2872BEFF2870BDFF276FBCFF266DBCFF2466BEFF2364BDFF2363BCFF2361
          BBFF215FBAFFCBA295FFCBA294FFCBA294FFD3AFA3FFBC9081FFC1998CFFFCF9
          F7FFFCF7F5FFFCF7F6FFFBF8F5FF2973C4FFB7E6FAFF74CFF5FF74CFF6FF73CF
          F6FF2468BFFFFCF7F5FFFCF7F4FFFBF6F4FFFCF8F7FFBE9285FFC29B8FFFFCF9
          F8FFFCF8F6FFFDF9F7FFFCF8F7FF2973C4FFB7E6FAFF90DAF7FF90DAF8FF8FDA
          F8FF2468BFFFFCF8F7FFFBF8F6FFFCF8F6FFFCF9F7FFBF9688FFC39E91FFFCFA
          F9FFFCFAF9FFFCFAF8FFFCFAF9FF2D7CCAFFBBE9FBFFBBEAFBFFBBE9FBFFBBE9
          FAFF2A72C4FFFCF9F8FFFCF9F8FFFCFAF8FFFCFAF8FFC1998BFF91776EC0C4A0
          94FFC4A094FFC49F93FFC39F93FF3084CDFF3082CDFF2E81CCFF2E7FCBFF2D7E
          CAFF2C7CCAFFC39D90FFC29C90FFC29C90FFC29C90FF907469C0000000020000
          0003000000040000000400000004000000040000000400000004000000040000
          0004000000040000000400000004000000040000000400000003}
        TabOrder = 0
        OnClick = btnCalcularClick
      end
      object btnGerarOP: TBitBtnLocked
        Left = 230
        Top = 0
        Width = 230
        Height = 22
        Caption = '[F10] Gerar Ordens de Produ'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000E000000150000000C0000
          0002000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000200000012072B199C136940FF051E127A0000
          000C000000010000000000000000000000000000000000000000000000000000
          0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
          063D000000060000000000000000000000000000000000000000000000000000
          0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
          2BCE000000150000000200000000000000000000000000000000000000000000
          00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
          65FF082B1A8A0000000C00000001000000000000000000000000000000000000
          00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
          9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
          00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
          B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
          0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
          AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
          0000000000030000000600000005000000020000000000000002010302121A63
          44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
          0000000000000000000000000000000000000000000000000000000000020105
          03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010002010B15573DA5509769FF0822184A00000004000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000004000000060000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnGerarOPClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 934
      Top = 2
      ExplicitLeft = 934
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 585
    Width = 1014
    TabOrder = 6
    ExplicitTop = 585
    ExplicitWidth = 1014
    inherited pnlNomeForm: TPanel
      Left = 843
      ExplicitLeft = 843
    end
    inherited pnlInfo: TPanel
      Width = 843
      ExplicitWidth = 843
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 184
    Width = 1014
    Height = 373
    Align = alBottom
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTbv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxgItensTbvEditKeyDown
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensTbvCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        PropertiesClassName = 'TcxLabelProperties'
        Width = 50
      end
      object cxgItensTbvDESITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'DESITE'
        PropertiesClassName = 'TcxLabelProperties'
        Width = 312
      end
      object cxgItensTbvSIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'SIGUNI'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 32
      end
      object cxgItensTbvSALDOS: TcxGridDBColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'SALDOS'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgItensTbvSALDIS: TcxGridDBColumn
        Caption = 'Est. Disp.'
        DataBinding.FieldName = 'SALDIS'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgItensTbvESTMIN: TcxGridDBColumn
        Caption = 'Est. Min.'
        DataBinding.FieldName = 'ESTMIN'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgItensTbvESTMAX: TcxGridDBColumn
        Caption = 'Est. M'#225'x.'
        DataBinding.FieldName = 'ESTMAX'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgItensTbvOPSPEN: TcxGridDBColumn
        Caption = 'OPs Pendentes'
        DataBinding.FieldName = 'OPSPEN'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgItensTbvSUGEST: TcxGridDBColumn
        Caption = 'Sugest'#227'o'
        DataBinding.FieldName = 'SUGEST'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.OnEditValueChanged = cxgItensTbvSUGESTPropertiesEditValueChanged
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
    end
    object cxgItensLvl: TcxGridLevel
      GridView = cxgItensTbv
    end
  end
  object gpbGranel: TcxGroupBox [4]
    Left = 6
    Top = 1
    Caption = 'Produto'
    Style.BorderColor = clBlack
    Style.LookAndFeel.NativeStyle = True
    Style.Shadow = True
    StyleDisabled.LookAndFeel.NativeStyle = True
    TabOrder = 0
    Height = 92
    Width = 634
    object Label1: TLabel
      Left = 10
      Top = 43
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label3: TLabel
      Left = 45
      Top = 20
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label2: TLabel
      Left = 38
      Top = 66
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 81
      Top = 39
      Width = 57
      Height = 22
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 1
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 138
      Top = 39
      Width = 485
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 81
      Top = 16
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 138
      Top = 16
      Width = 485
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 81
      Top = 62
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 138
      Top = 62
      Width = 485
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object gpbExibicao: TcxGroupBox [5]
    Left = 320
    Top = 97
    Caption = 'Op'#231#245'es:'
    Style.BorderColor = clBlack
    Style.LookAndFeel.NativeStyle = True
    Style.Shadow = True
    StyleDisabled.LookAndFeel.NativeStyle = True
    TabOrder = 3
    Height = 78
    Width = 320
    object chkSemNecessidade: TCheckBox
      Left = 11
      Top = 14
      Width = 270
      Height = 17
      Caption = 'Exibir produtos sem necessidade de produ'#231#227'o'
      TabOrder = 0
    end
    object chkOpsPen: TCheckBox
      Left = 11
      Top = 29
      Width = 222
      Height = 17
      Caption = 'Considerar ordem de produ'#231#227'o pendente'
      TabOrder = 1
    end
    object chkEstMax: TCheckBox
      Left = 11
      Top = 45
      Width = 302
      Height = 17
      Caption = 'Calcular necessidade de produ'#231#227'o at'#233' o estoque m'#225'ximo'
      TabOrder = 2
    end
    object chkValidaSaldosSubItens: TCheckBox
      Left = 11
      Top = 61
      Width = 302
      Height = 17
      Caption = 'Validar saldo dispon'#237'vel dos subitens da estrutura'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object rdgEstoque: TcxRadioGroup [6]
    Left = 6
    Top = 97
    Caption = 'Filtros de Estoque:'
    Properties.Items = <
      item
        Caption = 'Todos'
      end
      item
        Caption = 'Abaixo de estoque m'#237'nimo'
      end
      item
        Caption = 'Estoque negativo'
      end>
    ItemIndex = 0
    TabOrder = 1
    Height = 78
    Width = 163
  end
  object rdgCalculo: TcxRadioGroup [7]
    Left = 175
    Top = 97
    Caption = 'C'#225'lcular sugest'#227'o por:'
    Properties.Items = <
      item
        Caption = 'Estoque'
      end
      item
        Caption = 'Estoque dispon'#237'vel'
      end>
    ItemIndex = 0
    TabOrder = 2
    Height = 78
    Width = 139
  end
end
