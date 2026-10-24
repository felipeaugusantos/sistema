inherited frmRcxConfCupomModal: TfrmRcxConfCupomModal
  Left = 422
  Top = 460
  Width = 420
  Height = 267
  BorderIcons = [biSystemMenu]
  Caption = 'Modalidades'
  Position = poMainFormCenter
  ExplicitWidth = 420
  ExplicitHeight = 267
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 196
    Width = 414
    Height = 26
    ExplicitTop = 196
    ExplicitWidth = 414
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 256
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 410
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 335
      Top = 2
      Align = alRight
      ExplicitLeft = 331
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnConfirmaClick
      ExplicitLeft = 5
      ExplicitTop = 3
    end
  end
  object pnlTitulo: TPanel [2]
    Left = 0
    Top = 0
    Width = 414
    Height = 32
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'MODALIDADES DE RECEBIMENTO'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object pnlModalidades: TPanel [3]
    Left = 0
    Top = 89
    Width = 414
    Height = 11
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    ExplicitHeight = 9
    object scrModalidades: TScrollBox
      Left = 2
      Top = 2
      Width = 410
      Height = 7
      VertScrollBar.Increment = 0
      VertScrollBar.ParentColor = False
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      ExplicitHeight = 5
    end
  end
  object pnlTroco: TPanel [4]
    Left = 0
    Top = 100
    Width = 414
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    ExplicitTop = 98
    object ColorLabel1: TColorLabel
      Left = 16
      Top = 34
      Width = 149
      Height = 23
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'TROCO:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      CorDestaque = clRed
    end
    object ColorLabel2: TColorLabel
      Left = 16
      Top = 8
      Width = 149
      Height = 23
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'VALOR DIGITADO:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      CorDestaque = clRed
    end
    object edtValDig: TEditFocus
      Left = 172
      Top = 8
      Width = 155
      Height = 23
      Alignment = taRightJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.00'
    end
    object edtValTro: TEditFocus
      Left = 172
      Top = 34
      Width = 155
      Height = 23
      Alignment = taRightJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.00'
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 32
    Width = 414
    Height = 57
    Margins.Bottom = 10
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
    object lblTotal: TColorLabel
      Left = 8
      Top = 29
      Width = 157
      Height = 23
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'VALOR TOTAL:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      CorDestaque = clRed
    end
    object lblCgcCpf: TColorLabel
      Left = 8
      Top = 5
      Width = 155
      Height = 23
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CPF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      CorDestaque = clRed
    end
    object edtTotDoc: TEditFocus
      Left = 172
      Top = 29
      Width = 155
      Height = 23
      Alignment = taRightJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.00'
    end
    object mskCgcCpf: TMaskEditFocus
      Left = 172
      Top = 5
      Width = 155
      Height = 23
      Ctl3D = True
      EditMask = '999.999.999-99;0;'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 164
    Width = 414
    Height = 32
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    ExplicitTop = 162
    object chkEndEnt: TCheckBox
      Left = 16
      Top = 7
      Width = 257
      Height = 17
      Caption = 'Imprimir endere'#231'o de entrega'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 222
    Width = 414
    ExplicitTop = 222
    ExplicitWidth = 414
    inherited pnlNomeForm: TPanel
      Left = 243
      ExplicitLeft = 243
    end
    inherited pnlInfo: TPanel
      Width = 243
      ExplicitWidth = 243
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 112
  end
end
