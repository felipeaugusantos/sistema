inherited frmCadGruOperador: TfrmCadGruOperador
  Left = 219
  Top = 146
  Width = 476
  Height = 381
  VertScrollBar.Range = 69
  Caption = 'Cadastro de Grupo de Usu'#225'rio'
  ExplicitWidth = 476
  ExplicitHeight = 381
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 285
    Width = 470
    Height = 52
    TabOrder = 1
    ExplicitTop = 285
    ExplicitWidth = 470
    ExplicitHeight = 52
    DesignSize = (
      470
      52)
    inherited btnSair: TBitBtnLocked
      Left = 375
      Top = 28
      Width = 91
      TabOrder = 8
      ExplicitLeft = 375
      ExplicitTop = 28
      ExplicitWidth = 91
    end
    inherited btnIncluir: TBitBtnLocked
      Width = 91
      ExplicitWidth = 91
    end
    inherited btnGravar: TBitBtnLocked
      Left = 96
      Width = 91
      ExplicitLeft = 96
      ExplicitWidth = 91
    end
    inherited btnCancela: TBitBtnLocked
      Left = 4
      Top = 28
      Width = 91
      TabOrder = 4
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 91
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 282
      Width = 91
      Caption = '&Excluir Grupo'
      TabOrder = 3
      ExplicitLeft = 282
      ExplicitWidth = 91
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 96
      Top = 28
      Width = 91
      ExplicitLeft = 96
      ExplicitTop = 28
      ExplicitWidth = 91
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 189
      Width = 91
      ExplicitLeft = 189
      ExplicitWidth = 91
    end
    object btnInsOperador: TBitBtnLocked
      Left = 189
      Top = 28
      Width = 91
      Height = 20
      Hint = 'Insere Operador ao Grupo'
      Caption = 'Ins Oper.'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF9632099932089932089C32099C32099C32099C31079C
        30079A3309983309FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF953209973106
        C23B13ED4631F65039F75F41F7664CF75542EE4630B23A18953108FF00FFFF00
        FFFF00FFFF00FFFF00FF9332099A3108CF3D19F3573DFB734EFA6541FBAD9CFA
        B7B0EF452EBF3D2195330BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9E320B
        DC4725FE7552FF7048FF7757FFE9E5FFE9E5F46447B1391A92320BFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF9A340DCC4C28FC7042F2663FD4A195E1F3F2FE
        CCBBFF7752C14B27923009FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        DE52237A2F2830235316296D213270533B52CE512AC14819FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0D1E7D00229803228C011C8700
        1374181B64FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000A290A3EBB0D3BAA0D3CAA0D3AA90C3AAA012297FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000092766145CEF104ECC0F49C10F47BF11
        4DC50F43B5FF00FFFF00FFFF00FF1C65081C6508FF00FFFF00FFFF00FF000000
        07275A145BCE114AAB0F48BB0E41B21357D01354D0FF00FFFF00FFFF00FF1C65
        081C6508FF00FFFF00FFFF00FF0101010507080003070A2D571D7DEE1A70ED1C
        7AF6155FE7FF00FF1C65081C650818811D187E1C1C65081C6508FF00FF242220
        242220221E18071F3A1673C9208BEF1E86E90D36A4FF00FF1C65081C65081877
        181877181C65081C6508FF00FFFF00FF2725235A5959514E4C2529320A172807
        1120FF00FFFF00FFFF00FFFF00FF1C65081C6508FF00FFFF00FFFF00FFFF00FF
        FF00FF7877757877756B655F1F1A16FF00FFFF00FFFF00FFFF00FFFF00FF1C65
        081C6508FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnInsOperadorClick
    end
    object btnRemOperador: TBitBtnLocked
      Left = 282
      Top = 28
      Width = 91
      Height = 20
      Hint = 'Remove Operador do Grupo'
      Caption = 'Rem Oper.'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF9632099932089932089C32099C32099C32099C31079C
        30079A3309983309FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF953209973106
        C23B13ED4631F65039F75F41F7664CF75542EE4630B23A18953108FF00FFFF00
        FFFF00FFFF00FFFF00FF9332099A3108CF3D19F3573DFB734EFA6541FBAD9CFA
        B7B0EF452EBF3D2195330BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9E320B
        DC4725FE7552FF7048FF7757FFE9E5FFE9E5F46447B1391A92320BFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF9A340DCC4C28FC7042F2663FD4A195E1F3F2FE
        CCBBFF7752C14B27923009FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        DE52237A2F2830235316296D213270533B52CE512AC14819FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0D1E7D00229803228C011C8700
        1374181B64FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000A290A3EBB0D3BAA0D3CAA0D3AA90C3AAA012297FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000092766145CEF104ECC0F49C10F47BF11
        4DC50F43B5FF00FF0000BE0000BEFF00FF0000BE0000BEFF00FFFF00FF000000
        07275A145BCE114AAB0F48BB0E41B21357D01354D0FF00FF0000BE0000BE0000
        BE0000BE0000BEFF00FFFF00FF0101010507080003070A2D571D7DEE1A70ED1C
        7AF6155FE7FF00FFFF00FF0000BE0000BE0000BEFF00FFFF00FFFF00FF242220
        242220221E18071F3A1673C9208BEF1E86E90D36A4FF00FF0000BE0000BE0000
        BE0000BE0000BEFF00FFFF00FFFF00FF2725235A5959514E4C2529320A172807
        1120FF00FFFF00FF0000BE0000BEFF00FF0000BE0000BEFF00FFFF00FFFF00FF
        FF00FF7877757877756B655F1F1A16FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnRemOperadorClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 337
    Width = 470
    TabOrder = 3
    ExplicitTop = 337
    ExplicitWidth = 470
    inherited pnlNomeForm: TPanel
      Left = 298
      Width = 172
      ExplicitLeft = 298
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 298
      ExplicitWidth = 298
    end
  end
  inherited pgcDados: TPageControl
    Width = 470
    Height = 285
    Visible = False
    ExplicitWidth = 470
    ExplicitHeight = 285
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 462
      ExplicitHeight = 253
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 470
    Height = 285
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object pnlDependentes: TPanel
      Left = 2
      Top = 67
      Width = 466
      Height = 21
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'O P E R A D O R E S '
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlCab: TPanel
      Left = 2
      Top = 2
      Width = 466
      Height = 65
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object Label2: TLabel
        Left = 23
        Top = 14
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object lblDescricao: TLabel
        Left = 7
        Top = 37
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label1: TLabel
        Left = 258
        Top = 14
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data de Cadastro:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 10
        Width = 57
        Height = 22
        DataField = 'GPO_CODGPO'
        DataSource = frmModulo.dtsCadGpo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDescricao: TDBEditFocus
        Tag = 99
        Left = 61
        Top = 33
        Width = 381
        Height = 22
        CharCase = ecUpperCase
        DataField = 'GPO_DESCRI'
        DataSource = frmModulo.dtsCadGpo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clPurple
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaCad: TDBEditFocus
        Left = 349
        Top = 10
        Width = 93
        Height = 22
        TabStop = False
        DataField = 'GPO_DTACAD'
        DataSource = frmModulo.dtsCadGpo
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbgOperador: TDBGridCitel
      Left = 2
      Top = 88
      Width = 466
      Height = 195
      Align = alClient
      DataSource = frmModulo.dtsGruOpe
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'OPE_CODOPE'
          Title.Caption = 'Login'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPE_DESCRI'
          Title.Caption = 'Nome'
          Width = 294
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 152
  end
end
