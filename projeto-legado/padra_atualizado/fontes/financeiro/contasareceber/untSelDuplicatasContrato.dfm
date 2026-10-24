inherited frmSelDuplicatasContrato: TfrmSelDuplicatasContrato
  Left = 195
  Top = 179
  Width = 596
  Height = 600
  Caption = 'Sele'#231#227'o de Duplicatas por Contrato'
  ExplicitWidth = 596
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object splAplicacao: TSplitter [0]
    Left = 0
    Top = 299
    Width = 580
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    MinSize = 20
    ResizeStyle = rsNone
    ExplicitLeft = -8
    ExplicitTop = 274
    ExplicitWidth = 800
  end
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 580
    Height = 26
    ExplicitTop = 519
    ExplicitWidth = 573
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 461
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 569
      ExplicitHeight = 25
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 115
        ExplicitWidth = 115
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 115
        Width = 115
        ExplicitLeft = 115
        ExplicitWidth = 115
      end
      object btnConfirma: TBitBtnLocked
        Left = 230
        Top = 0
        Width = 115
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 345
        Top = 0
        Width = 115
        Height = 22
        Caption = '&Remover Duplicata'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 463
      Top = 2
      Width = 115
      Align = alRight
      ExplicitLeft = 463
      ExplicitTop = 4
      ExplicitWidth = 115
    end
  end
  inherited pnlHeader: TPanel
    Width = 580
    Height = 49
    ExplicitWidth = 573
    ExplicitHeight = 49
    object lblCheque: TLabel
      Left = 8
      Top = 3
      Width = 237
      Height = 17
      Caption = 'Passe o Contrato desejado no Leitor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object spbClientes: TSpeedButton
      Left = 299
      Top = 21
      Width = 218
      Height = 22
      Caption = 'Pressione [ F1 ] para buscar por Cliente'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF004B00004B00FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B0034CB
        5C17A72B004B00004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF004B003ED76D3ED76D25BA430C9718004B00FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004B003ED7
        6D34CB5B004B00004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF004B00004B00FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF035A9102416A045486FF00FFFF00FFFF00
        FF004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF02558E28
        82A55339240911140B5B88FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF02558E1CBFFF3692ADFFCF8962442D0D2433FF00FF0038
        6C00386CFF00FFFF00FFFF00FFFF00FFFF00FF02558E1BADEB1697D53FC5FE5D
        BAE0DAA976CB925E161D230E609600386C00386C033E64FF00FFFF00FFFF00FF
        02558E2BC2FE51D4FF41A0D099D3EFEDFFFFD4D0C9836E5818445B44ABDE4AAD
        D7695A460A0A09013B650460991680B85CD3FF8CDDFFC1EDFFD0EBF74093B89D
        CCE272BBDD2182B60C96CF31C2FF1AA5E0C2AC86623C2300243D03518802558E
        BFE5F7F8FFFFEEFBFFD0F2FF45ABD7027FB60075AA006FA50493C91FB7F81EC1
        FF64A5AD725033002A4702558EAAD0E302558E8AC5DE7ACEF457D0FF39CAFF1E
        AFED0B84C00173AA0089BC0FA1DC21BCFB129DDD0C4B6D004476FF00FF02558E
        02558E02558E148AC51498D71CB1F221BAFA1FB4F417A1E00774AC00578A0660
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF056BA504649E08
        7AB50474AF005188FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = spbClientesClick
    end
    object edtContrato: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 289
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      TabOrder = 0
      OnChange = edtContratoChange
      OnEnter = edtContratoEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 301
    Width = 580
    Height = 0
    Enabled = False
    Visible = True
    ExplicitTop = 298
    ExplicitWidth = 573
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 110
    Width = 580
    Height = 189
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_DUPPAR'
        Title.Caption = 'Documento'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Caption = 'Emp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Caption = 'Data Cadastro'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Caption = 'Data Venc.'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_VALDUP'
        Title.Caption = 'Val. Duplicata'
        Width = 72
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 70
    Width = 580
    ExplicitTop = 70
    ExplicitWidth = 573
  end
  object dbgDupSel: TDBGridCitel [7]
    Left = 0
    Top = 322
    Width = 580
    Height = 197
    Align = alBottom
    DataSource = dtsDupSel
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 6
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_DUPPAR'
        Title.Caption = 'Documento'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Caption = 'Emp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Caption = 'Data Cadastro'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Caption = 'Data Venc.'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_VALDUP'
        Title.Caption = 'Val. Duplicata'
        Width = 72
        Visible = True
      end>
  end
  object Panel1: TPanel [8]
    Left = 0
    Top = 301
    Width = 580
    Height = 21
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'DUPLICATAS SELECIONADAS'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 7
    ExplicitTop = 298
    ExplicitWidth = 573
  end
  object Panel2: TPanel [9]
    Left = 0
    Top = 49
    Width = 580
    Height = 21
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'DUPLICATAS DO CONTRATO'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 8
    ExplicitWidth = 573
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 580
    ExplicitTop = 545
    ExplicitWidth = 573
    inherited pnlNomeForm: TPanel
      Left = 409
      ExplicitLeft = 402
    end
    inherited pnlInfo: TPanel
      Width = 409
      ExplicitWidth = 402
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 136
  end
  inherited qryConsulta: TUniQuery
    Left = 144
    Top = 136
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 176
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    Left = 208
    Top = 136
  end
  inherited dtsConsulta: TDataSource
    Left = 240
    Top = 136
  end
  object dtsDupSel: TDataSource
    DataSet = cdsConsulta
    Left = 240
    Top = 456
  end
end
