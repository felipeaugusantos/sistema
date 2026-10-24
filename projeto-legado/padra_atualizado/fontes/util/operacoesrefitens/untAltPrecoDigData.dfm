inherited frmAltPrecoDigData: TfrmAltPrecoDigData
  Left = 311
  Top = 258
  Width = 321
  Height = 170
  BorderIcons = [biSystemMenu]
  Caption = 'Op'#231#227'o de Grava'#231#227'o'
  Position = poScreenCenter
  ExplicitWidth = 321
  ExplicitHeight = 170
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 98
    Width = 315
    ExplicitTop = 98
    ExplicitWidth = 315
    DesignSize = (
      315
      28)
    inherited btnSair: TBitBtnLocked
      Left = 234
      TabOrder = 1
      ExplicitLeft = 234
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 126
    Width = 315
    ExplicitTop = 126
    ExplicitWidth = 315
    inherited pnlNomeForm: TPanel
      Left = 144
      ExplicitLeft = 144
    end
    inherited pnlInfo: TPanel
      Width = 144
      ExplicitWidth = 144
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 315
    Height = 98
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblTitulo: TLabel
      Left = 13
      Top = 55
      Width = 82
      Height = 14
      Caption = 'Data de Previs'#227'o'
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 13
      Top = 69
      Width = 290
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 3
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 30
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object mskDtaPre: TMaskEditFocus
      Left = 13
      Top = 69
      Width = 85
      Height = 22
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rdbDtaPre: TRadioButton
      Left = 70
      Top = 14
      Width = 175
      Height = 17
      Caption = 'Programar Data de Previs'#227'o'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbDtaPreClick
    end
    object rdbTabDin: TRadioButton
      Left = 70
      Top = 34
      Width = 175
      Height = 17
      Caption = 'Criar Tabela de Pre'#231'o Din'#226'mica'
      TabOrder = 1
      OnClick = rdbDtaPreClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 8
  end
end
