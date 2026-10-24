inherited frmDigValor: TfrmDigValor
  Left = 592
  Top = 447
  Width = 226
  Height = 176
  Caption = 'Recebimento'
  ExplicitWidth = 226
  ExplicitHeight = 176
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 220
    Height = 25
    TabOrder = 1
    ExplicitTop = 96
    ExplicitWidth = 204
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 139
      Height = 21
      ExplicitWidth = 123
      ExplicitHeight = 21
    end
    inherited btnSair: TBitBtnLocked
      Left = 141
      Top = 2
      Height = 21
      Align = alRight
      ExplicitLeft = 125
      ExplicitTop = 2
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 131
    Width = 220
    TabOrder = 2
    ExplicitTop = 121
    ExplicitWidth = 204
    inherited pnlNomeForm: TPanel
      Left = 115
      Width = 105
      ExplicitLeft = 99
      ExplicitWidth = 105
    end
    inherited pnlInfo: TPanel
      Width = 115
      ExplicitWidth = 99
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 220
    Height = 106
    Align = alClient
    ParentColor = True
    TabOrder = 0
    ExplicitWidth = 204
    ExplicitHeight = 96
    object lblUnitario: TLabel
      Left = 24
      Top = 10
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digite o valor:'
    end
    object lblEmbalagem: TLabel
      Left = 7
      Top = 38
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Embalagem:'
    end
    object chkReplica: TCheckBox
      Left = 16
      Top = 58
      Width = 258
      Height = 17
      Caption = 'Replicar para todas as tabelas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 93
      Top = 3
      Width = 107
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 0
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
    object cmbTipVal: TComboBoxFocus
      Left = 209
      Top = 3
      Width = 90
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Cr'#233'dito'
      Visible = False
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtEmbalagem: TEditFocus
      Tag = 99
      Left = 93
      Top = 31
      Width = 107
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 2
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
    object chkReplicaItens: TCheckBox
      Left = 16
      Top = 77
      Width = 258
      Height = 17
      Caption = 'Replicar valor para todos os itens'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 65520
  end
end
