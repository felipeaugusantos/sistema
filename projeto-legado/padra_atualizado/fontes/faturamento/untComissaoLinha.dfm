inherited frmComissaoLinha: TfrmComissaoLinha
  Width = 693
  Height = 528
  Caption = 'Comiss'#227'o Composta para Vendedor por Linha do Produto'
  OnDestroy = FormDestroy
  ExplicitWidth = 693
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 455
    Width = 687
    ExplicitTop = 455
    ExplicitWidth = 687
    DesignSize = (
      687
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 683
      ExplicitTop = 2
      ExplicitWidth = 683
      inherited btnPesquisa: TBitBtnLocked
        Width = 81
        ExplicitWidth = 81
      end
      object btnHeranca: TBitBtnLocked
        Left = 441
        Top = 0
        Width = 123
        Height = 20
        Caption = 'Copiar Co&miss'#227'o'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF848484FF848484FF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF8484
          84FF848484FF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FFFFFF
          FFFF9D9D9DFFE6E6E6FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF9D9D
          9DFFE6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FFE6E6
          E6FFFFFFFFFF848484FF848484FF848484FF848484FF00000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFAFAFAFA7B7B7BDD1A1A1A3300000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF7B7B7BDD1A1A1A330000000000000000000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF838383FE848484FF1A1A1A33000000000000000000000000}
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 599
      ExplicitLeft = 599
    end
  end
  inherited pnlStatus: TPanel
    Top = 483
    Width = 687
    ExplicitTop = 483
    ExplicitWidth = 687
    inherited pnlNomeForm: TPanel
      Left = 340
      Caption = 'frmComissaoLinha'
      ExplicitLeft = 340
    end
    inherited pnlInfo: TPanel
      Width = 340
      ExplicitWidth = 340
    end
  end
  inherited pgcDados: TPageControl
    Width = 687
    Height = 455
    ExplicitWidth = 687
    ExplicitHeight = 455
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 679
      ExplicitHeight = 423
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 679
        Height = 77
        Align = alTop
        TabOrder = 0
        object lblCodVen: TLabel
          Left = 12
          Top = 14
          Width = 50
          Height = 14
          Caption = 'Vendedor:'
        end
        object lblEmp: TLabel
          Left = 17
          Top = 42
          Width = 45
          Height = 14
          Caption = 'Empresa:'
        end
        object edtCodVen: TEditFocus
          Tag = 99
          Left = 65
          Top = 11
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 0
          OnExit = edtCodVenExit
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesVen: TEditFocus
          Left = 103
          Top = 11
          Width = 445
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 65
          Top = 39
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 2
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesEmp: TEditFocus
          Left = 103
          Top = 39
          Width = 445
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
      end
      object pnlCamposItens: TPanel
        Left = 0
        Top = 77
        Width = 679
        Height = 112
        Align = alClient
        TabOrder = 1
        object lblPerFat: TLabel
          Left = 142
          Top = 57
          Width = 113
          Height = 14
          Caption = 'Comiss'#227'o Faturamento:'
        end
        object lblPerMix: TLabel
          Left = 288
          Top = 57
          Width = 69
          Height = 14
          Caption = 'Comiss'#227'o Mix:'
        end
        object lblPerMar: TLabel
          Left = 435
          Top = 57
          Width = 91
          Height = 14
          Caption = 'Comiss'#227'o Margem:'
        end
        object lblLinha: TLabel
          Left = 12
          Top = 6
          Width = 29
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblVlrMet: TLabel
          Left = 12
          Top = 57
          Width = 89
          Height = 14
          Caption = 'Meta Faturamento:'
        end
        object lblPorcentagem: TLabel
          Left = 257
          Top = 77
          Width = 12
          Height = 16
          Caption = '%'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 403
          Top = 77
          Width = 12
          Height = 16
          Caption = '%'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 550
          Top = 77
          Width = 12
          Height = 16
          Caption = '%'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtPerFat: TEditFocus
          Left = 142
          Top = 73
          Width = 113
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 12
          TabOrder = 3
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 18
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object btnConfirmar: TBitBtnLocked
          Left = 593
          Top = 70
          Width = 75
          Height = 25
          Caption = 'Confirmar'
          Enabled = False
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000090000
            000E000000100000001000000010000000100000001000000011000000110000
            0011000000110000001100000011000000100000000B0000000377544AC1A474
            66FFA47465FFA47465FFA37364FFA37264FFA27263FFA27263FFA27162FFA271
            62FFA17062FFA17061FFA17061FFA17061FF735046C30000000AAC7E71FFF8F1
            EEFFF8F0EDFFF8F1ECFFF8F0ECFFF8F0ECFFF5EDE9FFF2EAE6FFF5EDE9FFF8EF
            EBFFF7EFEBFFF7EFEBFFF7EFEBFFF7F0EBFFA8796AFF0000000FAD8172FFF8F2
            EFFFF6EDE8FFF7EDE8FFF6ECE8FFF4EBE6FFE6DBD6FFA87A62FFE7DCD8FFF5EB
            E6FFF6EDE7FFF6ECE8FFF6ECE8FFF8F0ECFFA97B6BFF00000010AF8375FFF9F2
            EFFFF6ECE8FFF6EDE9FFF6ECE7FFEDE5E0FFAD836EFFC58A51FFB08975FFEDE4
            E0FFF6ECE7FFF6ECE8FFF6ECE8FFF8F1EDFFAA7C6DFF0000000FB18577FFF9F3
            F0FFF7EDE9FFF7EDE8FFF3EAE5FFCDB3A8FFAC6E41FFF7C67AFFA96B40FFCDB6
            ABFFF1E8E4FFF7EDE8FFF6EDE9FFF9F1EDFFAB7E6FFF0000000EB2887AFFF9F4
            F0FFF7EEE9FFF5EBE7FFE4D8D1FFA06544FFEFBE79FFF9CA82FFEDBB78FF9F63
            42FFE3D7D2FFF4EBE7FFF7EEE9FFF8F1EEFFAD8072FF0000000EB48A7CFFF9F4
            F1FFF7EEEAFFF4EBE7FFC69E83FFB47C54FFB47B53FFFACF88FFB37851FFB277
            4FFFC3987EFFF2E9E5FFF7EEE9FFF9F2EFFFAF8274FF0000000DB68D7FFFFAF4
            F2FFF7EEEAFFF6EDE9FFF2E9E5FFE9E1DDFFB77F57FFFDD48EFFB1744CFFE8DF
            DBFFF1E7E4FFF6EDE9FFF7EEEAFFF9F2EFFFB08476FF0000000CB88F82FFFAF5
            F2FFF7EEEAFFF7EEEBFFF7EEEAFFF0E7E5FFBA845CFFFEEAC1FFB2774FFFEFE7
            E3FFF7EEEAFFF7EFEAFFF7EEEAFFF9F3F0FFB28679FF0000000CB99184FFFAF5
            F3FFF8EFEBFFF7EFEAFFF7EFEBFFF2EAE6FFCB9E76FFCB9E76FFCB9E76FFF2E8
            E5FFF7EFEAFFF7EEEAFFF7EFEBFFFAF4F1FFB3897BFF0000000BBB9387FFFAF6
            F4FFF7EFEBFFF7EEEBFFF8EFEBFFF6EDEAFFF2EAE6FFF1E9E5FFF2EAE6FFF6ED
            EAFFF7EFEBFFF7EFEBFFF7EEEBFFFAF3F2FFB58B7DFF0000000AD4A477FFD8B1
            8BFFD2A373FFD1A372FFD1A272FFD1A170FFD0A070FFD09F6FFFCF9F6EFFCE9E
            6DFFCF9D6CFFCE9C6BFFCE9C6AFFD3A77CFFCE9764FF00000009D4A678FFEED7
            B6FFE2BB87FFE2BA86FFE2B985FFE2BA85FFE2BA85FFE1B984FFE1B984FFE1B8
            84FFE1B883FFE1B883FFE0B783FFEBD0AAFFCE9864FF00000009D4A679FFF1DC
            BCFFF0DCBCFFF0DBBCFFF0DBBCFFF0DCBBFFEFDABBFFEFDABBFFEFDABAFFEFDA
            B9FFEFD8B9FFEFD9B8FFEFD8B6FFEED5B1FFCE9865FF000000089E7B5AC0D4A6
            79FFD4A577FFD4A476FFD3A375FFD3A272FFD2A071FFD1A06FFFD09F6FFFD09D
            6DFFD09C6CFFD09B6AFFCF9B68FFCF9A67FF99714BC200000005}
          TabOrder = 6
          OnClick = btnConfirmarClick
        end
        object edtPerMix: TEditFocus
          Left = 288
          Top = 73
          Width = 113
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 12
          TabOrder = 4
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 18
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtPerMar: TEditFocus
          Left = 435
          Top = 73
          Width = 113
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 12
          TabOrder = 5
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 18
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object mskCodLin: TMaskEditFocus
          Tag = 99
          Left = 12
          Top = 21
          Width = 53
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 7
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnExit = mskCodLinExit
          OnKeyPress = mskCodLinKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesLin: TEditFocus
          Left = 66
          Top = 21
          Width = 482
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVlrMet: TEditFocus
          Left = 12
          Top = 73
          Width = 113
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          MaxLength = 12
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 18
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
      object pnlItens: TPanel
        Left = 0
        Top = 189
        Width = 679
        Height = 201
        Align = alBottom
        TabOrder = 2
        object dbgLinMet: TDBGridCitel
          Left = 1
          Top = 1
          Width = 677
          Height = 199
          Align = alClient
          DataSource = dtsLinMet
          Enabled = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDblClick = dbgLinMetDblClick
          OnKeyDown = dbgLinMetKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'LMT_DESLIN'
              Title.Caption = 'Linha'
              Width = 179
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LMT_VLRMET'
              Title.Caption = 'Meta Faturamento'
              Width = 103
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LMT_PERFAT'
              Title.Caption = '% Comiss'#227'o Faturamento'
              Width = 138
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LMT_PERMIX'
              Title.Caption = '% Comiss'#227'o Mix'
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LMT_PERMAR'
              Title.Caption = '% Comiss'#227'o Margem'
              Width = 107
              Visible = True
            end>
        end
      end
      object pnlLegendas: TPanel
        Left = 0
        Top = 390
        Width = 679
        Height = 33
        Align = alBottom
        TabOrder = 3
        object lblLegenda: TLabel
          Left = 181
          Top = 9
          Width = 247
          Height = 14
          Caption = 'Pressione [DELETE] para excluir um registro do grid'
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 24
    Top = 480
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 0
    Top = 480
  end
  object dtsLinMet: TUniDataSource
    DataSet = cdsLinMet
    Left = 276
    Top = 482
  end
  object cdsLinMet: TUniClientDataSet
    PersistDataPacket.Data = {
      E20000009619E0BD010000001800000008000000000003000000E2000A415554
      4F494E4352454D01004900000001000557494454480200020014000A4C4D545F
      434F444C494E01004900000001000557494454480200020014000A4C4D545F56
      4C524D455408000400000000000A4C4D545F5045524641540800040000000000
      0A4C4D545F5045524D495808000400000000000A4C4D545F5045524D41520800
      0400000000000A4C4D545F434F4D4C494E010049000000010005574944544802
      00020014000A4C4D545F4445534C494E01004900000001000557494454480200
      020064000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LMT_CODLIN'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LMT_VLRMET'
        DataType = ftFloat
      end
      item
        Name = 'LMT_PERFAT'
        DataType = ftFloat
      end
      item
        Name = 'LMT_PERMIX'
        DataType = ftFloat
      end
      item
        Name = 'LMT_PERMAR'
        DataType = ftFloat
      end
      item
        Name = 'LMT_COMLIN'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LMT_DESLIN'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterOpen = cdsLinMetAfterOpen
    OnCalcFields = cdsLinMetCalcFields
    Left = 300
    Top = 482
    object cdsLinMetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsLinMetLMT_CODLIN: TStringField
      FieldName = 'LMT_CODLIN'
    end
    object cdsLinMetLMT_VLRMET: TFloatField
      FieldName = 'LMT_VLRMET'
    end
    object cdsLinMetLMT_PERFAT: TFloatField
      FieldName = 'LMT_PERFAT'
    end
    object cdsLinMetLMT_PERMIX: TFloatField
      FieldName = 'LMT_PERMIX'
    end
    object cdsLinMetLMT_PERMAR: TFloatField
      FieldName = 'LMT_PERMAR'
    end
    object cdsLinMetLMT_COMLIN: TStringField
      FieldName = 'LMT_COMLIN'
    end
    object cdsLinMetLMT_DESLIN: TStringField
      FieldKind = fkCalculated
      FieldName = 'LMT_DESLIN'
      Size = 100
      Calculated = True
    end
  end
end
