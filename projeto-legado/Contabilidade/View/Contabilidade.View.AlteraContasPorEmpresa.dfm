inherited frmAlteraContasPorEmpresa: TfrmAlteraContasPorEmpresa
  Width = 555
  Height = 140
  BorderIcons = [biSystemMenu]
  Caption = 'Alterando Contas por Empresa'
  Position = poScreenCenter
  ExplicitWidth = 555
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 549
    Height = 26
    ExplicitTop = 69
    ExplicitWidth = 643
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 468
      Height = 22
      ExplicitLeft = 79
      ExplicitTop = 2
      ExplicitWidth = 485
      ExplicitHeight = 22
      object btnAdicionar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 89
        Height = 22
        Caption = '&Adicionar'
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
        OnClick = btnAdicionarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 470
      Top = 2
      Align = alRight
      ExplicitLeft = 564
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 549
    ExplicitTop = 95
    ExplicitWidth = 643
    inherited pnlNomeForm: TPanel
      Left = 378
      ExplicitLeft = 472
    end
    inherited pnlInfo: TPanel
      Width = 378
      ExplicitWidth = 472
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 549
    Height = 69
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 643
    object Label1: TLabel
      Left = 9
      Top = 15
      Width = 96
      Height = 14
      Caption = 'C'#243'digo da Empresa:'
    end
    object Label2: TLabel
      Left = 30
      Top = 43
      Width = 75
      Height = 14
      Caption = 'Plano de Conta:'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 111
      Top = 12
      Width = 58
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 171
      Top = 12
      Width = 366
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCon: TEditFocus
      Left = 238
      Top = 40
      Width = 299
      Height = 22
      Alignment = taLeftJustify
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
    object mskCodCon: TMaskEditFocus
      Tag = 99
      Left = 111
      Top = 40
      Width = 125
      Height = 22
      TabOrder = 2
      Text = ''
      OnKeyPress = mskCodConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 12
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 676
    Top = 12
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 728
    Top = 44
  end
  object dtsDados: TDataSource
    Left = 168
    Top = 173
  end
end
