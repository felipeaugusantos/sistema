inherited frmConfiguracaoPisCofinsReceitaFinanceira: TfrmConfiguracaoPisCofinsReceitaFinanceira
  Width = 554
  Height = 215
  Caption = 'Contabilizar PIS/COFINS sobre receitas financeiras'
  ExplicitWidth = 554
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 144
    Width = 548
    TabOrder = 2
    ExplicitTop = 144
    ExplicitWidth = 548
    inherited FlwBotoes: TFlowPanel
      Width = 544
      ExplicitWidth = 544
    end
    inherited btnSair: TBitBtnLocked
      Left = 468
      ExplicitLeft = 468
    end
  end
  inherited pnlStatus: TPanel
    Top = 170
    Width = 548
    TabOrder = 3
    ExplicitTop = 170
    ExplicitWidth = 548
    inherited pnlNomeForm: TPanel
      Left = 377
      ExplicitLeft = 377
    end
    inherited pnlInfo: TPanel
      Width = 377
      ExplicitWidth = 377
    end
  end
  object pnlAlq: TPanel [2]
    Left = 0
    Top = 40
    Width = 548
    Height = 104
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 19
      Width = 57
      Height = 14
      Caption = 'Al'#237'quota PIS'
    end
    object Label2: TLabel
      Left = 20
      Top = 59
      Width = 79
      Height = 14
      Caption = 'Al'#237'quota COFINS'
    end
    object Label3: TLabel
      Left = 143
      Top = 19
      Width = 10
      Height = 14
      Caption = '%'
    end
    object Label4: TLabel
      Left = 162
      Top = 59
      Width = 10
      Height = 14
      Caption = '%'
    end
    object edtAlqCof: TEditFocus
      Left = 102
      Top = 56
      Width = 54
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.0000'
    end
    object edtAlqPis: TEditFocus
      Left = 83
      Top = 18
      Width = 54
      Height = 22
      Alignment = taRightJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.0000'
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 548
    Height = 40
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object chkPICORF: TCheckBox
      Left = 8
      Top = 13
      Width = 97
      Height = 17
      Caption = 'Utilizar rotina'
      TabOrder = 0
      OnClick = chkPICORFClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 64
  end
end
