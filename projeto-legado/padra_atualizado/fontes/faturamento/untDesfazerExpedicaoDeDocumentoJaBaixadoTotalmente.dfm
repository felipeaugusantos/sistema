inherited frmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente: TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente
  Width = 625
  Height = 274
  BorderIcons = [biSystemMenu]
  Caption = 'Desfazer expedi'#231#227'o de documento j'#225' baixado totalmente'
  Position = poMainFormCenter
  ExplicitWidth = 625
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 201
    Width = 619
    TabOrder = 3
    ExplicitTop = 201
    ExplicitWidth = 619
    inherited FlwBotoes: TFlowPanel
      Width = 615
      ExplicitTop = 2
      ExplicitWidth = 615
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 539
      TabStop = False
      ExplicitLeft = 539
    end
  end
  inherited pnlStatus: TPanel
    Top = 229
    Width = 619
    TabOrder = 4
    ExplicitTop = 229
    ExplicitWidth = 619
    inherited pnlNomeForm: TPanel
      Left = 319
      Width = 300
      ExplicitLeft = 319
      ExplicitWidth = 300
    end
    inherited pnlInfo: TPanel
      Width = 319
      ExplicitWidth = 319
    end
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 171
    Width = 619
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object btnLimpaExpedicao: TBitBtnLocked
      Left = 10
      Top = 4
      Width = 147
      Height = 22
      Caption = 'Desfazer Expedi'#231#227'o'
      TabOrder = 0
      OnClick = btnLimpaExpedicaoClick
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 619
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 12
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object Label2: TLabel
      Left = 288
      Top = 12
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label3: TLabel
      Left = 190
      Top = 12
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 68
      Top = 9
      Width = 109
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 236
      Top = 9
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 336
      Top = 9
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
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
    object edtNomEmp: TEditFocus
      Left = 373
      Top = 9
      Width = 234
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCentro: TPanel [5]
    Left = 0
    Top = 41
    Width = 619
    Height = 130
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object memInfDoc: TMemoFocus
      Left = 0
      Top = 0
      Width = 619
      Height = 130
      Align = alClient
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 524
    Top = 116
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 116
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 116
  end
end
