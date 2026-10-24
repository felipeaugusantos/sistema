inherited frmRcxSelecionaPortadorLiberacao: TfrmRcxSelecionaPortadorLiberacao
  Width = 498
  Height = 158
  Caption = 'Selecionar Portador'
  ExplicitWidth = 498
  ExplicitHeight = 158
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 492
    ExplicitTop = 87
    ExplicitWidth = 492
    inherited FlwBotoes: TFlowPanel
      Width = 488
      ExplicitWidth = 488
    end
    inherited btnSair: TBitBtnLocked
      Left = 409
      ExplicitLeft = 409
    end
  end
  inherited pnlStatus: TPanel
    Top = 113
    Width = 492
    ExplicitTop = 113
    ExplicitWidth = 492
    inherited pnlNomeForm: TPanel
      Left = 228
      Width = 264
      ExplicitLeft = 228
      ExplicitWidth = 264
    end
    inherited pnlInfo: TPanel
      Width = 228
      ExplicitWidth = 228
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 492
    Height = 87
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object lblPortador: TLabel
      Left = 35
      Top = 54
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblDescricao: TLabel
      Left = 25
      Top = 12
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aceitando:'
    end
    object lblValor: TLabel
      Left = 83
      Top = 12
      Width = 21
      Height = 14
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblModalidade: TLabel
      Left = 20
      Top = 28
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Modalidade:'
    end
    object lblModalidadeDescricao: TLabel
      Left = 83
      Top = 28
      Width = 130
      Height = 14
      Caption = 'lblModalidadeDescricao'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigoPortador: TEditFocus
      Tag = 99
      Left = 82
      Top = 50
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodigoPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomePortador: TEditFocus
      Left = 148
      Top = 50
      Width = 333
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 648
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 88
  end
end
