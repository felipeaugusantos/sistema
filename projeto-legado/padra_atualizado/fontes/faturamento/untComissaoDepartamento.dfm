inherited frmComissaoDepartamento: TfrmComissaoDepartamento
  Width = 623
  Height = 528
  Caption = 'Comiss'#227'o por Departamento X Tabela de Pre'#231'o'
  OldCreateOrder = False
  OnDestroy = FormDestroy
  ExplicitWidth = 623
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 455
    Width = 617
    ExplicitTop = 455
    ExplicitWidth = 617
    inherited FlwBotoes: TFlowPanel
      Width = 613
      ExplicitTop = 2
      ExplicitWidth = 613
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 531
      Height = 20
      ExplicitLeft = 531
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 483
    Width = 617
    ExplicitTop = 483
    ExplicitWidth = 617
    inherited pnlNomeForm: TPanel
      Left = 270
      Caption = 'frmComissaoDepartamento'
      ExplicitLeft = 270
    end
    inherited pnlInfo: TPanel
      Width = 270
      ExplicitWidth = 270
    end
  end
  inherited pgcDados: TPageControl
    Width = 617
    Height = 455
    ExplicitWidth = 617
    ExplicitHeight = 455
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 609
      ExplicitHeight = 423
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 609
        Height = 97
        Align = alTop
        TabOrder = 0
        object lblCodCom: TLabel
          Left = 96
          Top = 18
          Width = 36
          Height = 14
          Caption = 'C'#243'digo:'
        end
        object lblDesCom: TLabel
          Left = 198
          Top = 18
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object lblCodDep: TLabel
          Left = 12
          Top = 43
          Width = 120
          Height = 14
          Caption = 'Departamento Vendedor:'
        end
        object lblFatIni: TLabel
          Left = 40
          Top = 70
          Width = 92
          Height = 14
          Caption = 'Faturamento Inicial:'
        end
        object lblFatFin: TLabel
          Left = 239
          Top = 70
          Width = 88
          Height = 14
          Caption = 'Faturamento Final:'
        end
        object edtCodCom: TEditFocus
          Tag = 99
          Left = 135
          Top = 13
          Width = 58
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesCom: TEditFocus
          Tag = 99
          Left = 255
          Top = 13
          Width = 338
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 40
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 40
          TipoTexto = ttAlfanumerico
        end
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 135
          Top = 40
          Width = 58
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
          OnKeyPress = edtCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtFatIni: TEditFocus
          Tag = 99
          Left = 135
          Top = 67
          Width = 95
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 3
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtFatFin: TEditFocus
          Tag = 99
          Left = 333
          Top = 68
          Width = 95
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 4
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesDep: TEditFocus
          Left = 199
          Top = 40
          Width = 394
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
      object pnlCamposItens: TPanel
        Left = 0
        Top = 97
        Width = 609
        Height = 71
        Align = alClient
        TabOrder = 1
        object lblTabPre: TLabel
          Left = 12
          Top = 16
          Width = 77
          Height = 14
          Caption = 'Tabela de Pre'#231'o'
        end
        object lblPerCom: TLabel
          Left = 142
          Top = 16
          Width = 60
          Height = 14
          Caption = '% Comissao'
        end
        object edtPerCom: TEditFocus
          Left = 142
          Top = 32
          Width = 95
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 1
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object cmbTabPre: TComboBoxFocus
          Left = 12
          Top = 32
          Width = 113
          Height = 22
          AutoDropDown = True
          Style = csOwnerDrawFixed
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object btnConfirmar: TBitBtnLocked
          Left = 518
          Top = 29
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
          TabOrder = 2
          OnClick = btnConfirmarClick
        end
      end
      object pnlItens: TPanel
        Left = 0
        Top = 168
        Width = 609
        Height = 222
        Align = alBottom
        TabOrder = 2
        object dbgDepTab: TDBGridCitel
          Left = 1
          Top = 1
          Width = 607
          Height = 220
          Align = alClient
          DataSource = dtsDepTab
          Enabled = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDblClick = dbgDepTabDblClick
          OnKeyDown = dbgDepTabKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'DTB_CODTAB'
              Title.Caption = 'Tabela de Pre'#231'o'
              Width = 105
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DTB_PERCOM'
              Title.Caption = '% Comiss'#227'o'
              Width = 97
              Visible = True
            end>
        end
      end
      object pnlLegendas: TPanel
        Left = 0
        Top = 390
        Width = 609
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
  object cdsDepTab: TUniClientDataSet
    PersistDataPacket.Data = {
      8A0000009619E0BD0100000018000000040000000000030000008A000A415554
      4F494E4352454D01004900000001000557494454480200020014000A4454425F
      434F44434F4D01004900000001000557494454480200020014000A4454425F43
      4F4454414201004900000001000557494454480200020014000A4454425F5045
      52434F4D08000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DTB_CODCOM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DTB_CODTAB'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DTB_PERCOM'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterOpen = cdsDepTabAfterOpen
    Left = 476
    Top = 458
    object cdsDepTabAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDepTabDTB_CODCOM: TStringField
      FieldName = 'DTB_CODCOM'
    end
    object cdsDepTabDTB_CODTAB: TStringField
      FieldName = 'DTB_CODTAB'
    end
    object cdsDepTabDTB_PERCOM: TFloatField
      FieldName = 'DTB_PERCOM'
    end
  end
  object dtsDepTab: TUniDataSource
    DataSet = cdsDepTab
    Left = 444
    Top = 458
  end
end
