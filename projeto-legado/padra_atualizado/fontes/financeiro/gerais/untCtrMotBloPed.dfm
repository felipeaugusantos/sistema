inherited frmCtrMotBloPed: TfrmCtrMotBloPed
  Left = 351
  Top = 317
  Width = 346
  Height = 341
  BorderIcons = [biSystemMenu]
  Caption = 'Motivo Bloqueio de Pedidos'
  Position = poMainFormCenter
  ExplicitWidth = 346
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 269
    Width = 340
    ExplicitTop = 269
    ExplicitWidth = 310
    inherited btnSair: TBitBtnLocked
      Left = 257
      ExplicitLeft = 227
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 340
    Height = 269
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 313
    ExplicitHeight = 265
    object Label1: TLabel
      Left = 8
      Top = 7
      Width = 32
      Height = 14
      Caption = 'Pedido'
    end
    object Label6: TLabel
      Left = 101
      Top = 7
      Width = 40
      Height = 14
      Caption = 'Esp.Doc'
    end
    object Label4: TLabel
      Left = 160
      Top = 7
      Width = 69
      Height = 14
      Caption = 'Data Cadastro'
    end
    object Label5: TLabel
      Left = 246
      Top = 7
      Width = 70
      Height = 14
      Caption = 'Hora Cadastro'
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object Label3: TLabel
      Left = 8
      Top = 81
      Width = 47
      Height = 14
      Caption = 'Vendedor'
    end
    object Label7: TLabel
      Left = 8
      Top = 118
      Width = 46
      Height = 14
      Caption = 'Operador'
    end
    object Label8: TLabel
      Left = 8
      Top = 155
      Width = 63
      Height = 14
      Caption = 'Observa'#231#227'o:'
    end
    object edtPed: TEditFocus
      Left = 8
      Top = 21
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Left = 101
      Top = 21
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaCad: TEditFocus
      Left = 160
      Top = 21
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtHorCad: TEditFocus
      Left = 246
      Top = 21
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Left = 8
      Top = 58
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmp: TEditFocus
      Left = 101
      Top = 58
      Width = 230
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Left = 8
      Top = 95
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVen: TEditFocus
      Left = 101
      Top = 95
      Width = 230
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodOpe: TEditFocus
      Left = 8
      Top = 132
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpe: TEditFocus
      Left = 101
      Top = 132
      Width = 230
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object memObserv: TMemoFocus
      Left = 8
      Top = 169
      Width = 323
      Height = 89
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited pnlStatus: TPanel
    Top = 297
    Width = 340
    ExplicitTop = 297
    ExplicitWidth = 310
    inherited pnlNomeForm: TPanel
      Left = 169
      ExplicitLeft = 139
    end
    inherited pnlInfo: TPanel
      Width = 169
      ExplicitWidth = 139
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 8
  end
end
