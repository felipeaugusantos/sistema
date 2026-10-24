inherited frmCadAjustIcmSt: TfrmCadAjustIcmSt
  Width = 708
  Height = 277
  Caption = 'Cadastro de Ajustes de ICMS-ST'
  ExplicitWidth = 708
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 14
  object Label40: TLabel [0]
    Left = 6
    Top = 0
    Width = 51
    Height = 14
    Caption = 'M'#234's / Ano:'
  end
  object Label1: TLabel [1]
    Left = 87
    Top = 0
    Width = 84
    Height = 14
    Caption = 'C'#243'digo do Ajuste:'
  end
  object Label2: TLabel [2]
    Left = 344
    Top = 0
    Width = 171
    Height = 14
    Caption = 'Descri'#231#227'o Complementar do Ajuste:'
  end
  object Label3: TLabel [3]
    Left = 601
    Top = 0
    Width = 76
    Height = 14
    Caption = 'Valor do Ajuste:'
  end
  object Label4: TLabel [4]
    Left = 201
    Top = 0
    Width = 110
    Height = 14
    Caption = 'C'#243'digo Receita (E250):'
  end
  inherited pgcDados: TPageControl [5]
    Width = 702
    Height = 0
    ActivePage = nil
    Align = alNone
    ExplicitWidth = 702
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 694
      ExplicitHeight = 226
    end
  end
  inherited pnlStatus: TPanel [6]
    Top = 232
    Width = 702
    ExplicitTop = 232
    ExplicitWidth = 702
    inherited pnlNomeForm: TPanel
      Left = 480
      Width = 222
      ExplicitLeft = 480
      ExplicitWidth = 222
    end
    inherited pnlInfo: TPanel
      Width = 480
      ExplicitWidth = 480
    end
  end
  object dbgridAjuste: TDBGridCitel [7]
    Left = 0
    Top = 44
    Width = 702
    Height = 163
    Align = alBottom
    DataSource = dtsTabela
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 9
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
        FieldName = 'AJI_MESANO'
        Title.Caption = 'M'#234's / Ano'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJI_CODAJU'
        Title.Caption = 'C'#243'digo do Ajuste'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJI_CODREC'
        Title.Caption = 'C'#243'digo Receita (E250)'
        Width = 115
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'AJI_DESAJU'
        Title.Caption = 'Descri'#231#227'o Complementar do Ajuste'
        Width = 260
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJI_VALAJU'
        Title.Caption = 'Valor do Ajuste'
        Width = 100
        Visible = True
      end>
  end
  object edtdbeMesAno: TDBEditFocus [8]
    Tag = 99
    Left = 4
    Top = 16
    Width = 79
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJI_MESANO'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttNumerico
  end
  object edtdbeCodAju: TDBEditFocus [9]
    Tag = 99
    Left = 85
    Top = 16
    Width = 112
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJI_CODAJU'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
  end
  object edtdbeDescricao: TDBEditFocus [10]
    Tag = 99
    Left = 343
    Top = 16
    Width = 256
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJI_DESAJU'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
  end
  object edtdbeValAju: TDBEditFocus [11]
    Tag = 99
    Left = 601
    Top = 16
    Width = 92
    Height = 22
    DataField = 'AJI_VALAJU'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttNumerico
  end
  object edtdbeCodRec: TDBEditFocus [12]
    Tag = 99
    Left = 199
    Top = 16
    Width = 142
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJI_CODREC'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
  end
  inherited pnlBotoes: TPanel [13]
    Top = 207
    Width = 702
    Height = 25
    ExplicitTop = 207
    ExplicitWidth = 702
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 621
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 698
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        Height = 21
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        Height = 21
        ExplicitLeft = 85
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        Height = 21
        ExplicitLeft = 170
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        Height = 21
        ExplicitLeft = 255
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        Height = 21
        ExplicitLeft = 340
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        Height = 21
        ExplicitLeft = 425
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 623
      Height = 21
      Align = alRight
      ExplicitLeft = 623
      ExplicitHeight = 21
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 120
  end
  object dtsTabela: TDataSource
    DataSet = qryAjuste
    Left = 111
    Top = 76
  end
  object qryAjuste: TUniQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM AJICST')
    Constraints = <>
    Left = 56
    Top = 80
  end
end
