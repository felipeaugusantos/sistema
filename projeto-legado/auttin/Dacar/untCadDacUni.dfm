inherited frmCadDacUni: TfrmCadDacUni
  Width = 497
  Height = 242
  BorderStyle = bsToolWindow
  Caption = 'Rela'#231#227'o de Unidades - Dacar'
  ExplicitWidth = 497
  ExplicitHeight = 242
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 24
    Width = 80
    Height = 14
    Caption = 'Unidades Dacar:'
  end
  object Label2: TLabel [1]
    Left = 104
    Top = 24
    Width = 88
    Height = 14
    Caption = 'Unidades AutCom:'
  end
  object btnAdicionar: TSpeedButton [2]
    Left = 280
    Top = 72
    Width = 23
    Height = 22
    Caption = '>'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    OnClick = btnAdicionarClick
  end
  object btnRemover: TSpeedButton [3]
    Left = 280
    Top = 96
    Width = 23
    Height = 22
    Caption = '<'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    OnClick = btnRemoverClick
  end
  object Label3: TLabel [4]
    Left = 312
    Top = 24
    Width = 42
    Height = 14
    Caption = 'Rela'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 174
    Width = 491
    ExplicitTop = 174
    ExplicitWidth = 491
    inherited btnSair: TBitBtnLocked
      Left = 408
      ExplicitLeft = 408
    end
  end
  inherited pnlStatus: TPanel
    Top = 202
    Width = 491
    ExplicitTop = 202
    ExplicitWidth = 491
    inherited pnlNomeForm: TPanel
      Left = 320
      ExplicitLeft = 320
    end
    inherited pnlInfo: TPanel
      Width = 320
      ExplicitWidth = 320
    end
  end
  object dbgUniDac: TDBGridCitel [7]
    Left = 8
    Top = 40
    Width = 89
    Height = 120
    Ctl3D = False
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = FormKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
  end
  object dbgCadUni: TDBGridCitel [8]
    Left = 104
    Top = 40
    Width = 169
    Height = 120
    Ctl3D = False
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = FormKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
  end
  object dbgRelacao: TDBGridCitel [9]
    Left = 312
    Top = 40
    Width = 169
    Height = 120
    Ctl3D = False
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = FormKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DAC_UNIDAC'
        Title.Caption = 'Dacar'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DAC_UNIAUT'
        Title.Caption = 'AutCom'
        Visible = True
      end>
  end
  object pnlCabecalho: TPanel [10]
    Left = 0
    Top = 0
    Width = 491
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Rela'#231#227'o de Unidades - Dacar'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 96
  end
end
