inherited frmLogin: TfrmLogin
  Left = 346
  Top = 261
  Width = 258
  Height = 194
  BorderIcons = [biSystemMenu]
  Caption = 'Login'
  Position = poScreenCenter
  ExplicitWidth = 258
  ExplicitHeight = 194
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 123
    Width = 252
    Height = 26
    BevelOuter = bvRaised
    ExplicitTop = 123
    ExplicitWidth = 252
    ExplicitHeight = 26
    DesignSize = (
      252
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 248
      Height = 22
      ExplicitWidth = 248
      ExplicitHeight = 22
      object btnLogin: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 21
        Anchors = [akRight, akBottom]
        Caption = '&Login'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFA03103B7380DE6462DF44835F34A35FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA33204BF3A11
          EB462FF6543CF75F41F7674FF4513EED412D8B4115FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFAB3307C73C18F3593EFB6E4AFB6D49FCC6BBF88E7FE2
          3A24843F1100760009991810AF3635BC4A40B53E007B00006600B5350CD54623
          FE6F4DFF6D44FF977BFFFFFFFFBAAAE94B2E7F3C0D078E131DC7531EC24399F2
          999EEF9F089311006800FF00FFD54623FF7249B65541968B8FB2BBBFE68A73FE
          5D3C914A160CA12114B03C2C8A3992B48F68BA6615AD30027407FF00FFFF00FF
          4146651E4F971255AB134E93734C52FF00FFFF00FF022204021C07091C4C0C1E
          660A2C3D129132FF00FFFF00FF1066A40C69D11C88FF1E86FF187AF31A67C2FF
          00FF00040A00000003092F082A9C062899061F89072976FF00FF1D688C2882C6
          2C97FF2D99FF2D99FC2D9AFF2897FE146DC40004070002070B34920F46C40E41
          B40F42B70C36B002158A1D688C2D8ED732A0FF319DFC2E98F62E98F733A3FF23
          7ECF010405010610114EBD1357D7114BC01152CB114EC60D36A01D688C1D688C
          2D8BC62F95E1319DFB319AF834A3FF1F73C2010407010204104FA71C7FFF1B74
          F21C78F7165ED410439A1D688C1D688C1D688C2F90D335A3FE35A4FF309CF311
          4F8802050814100C13273D0F4E9A1564BF196BC70C347010439AFF00FF1D688C
          1D688C1D688C1D688C1D688C1D688CFF00FFFF00FF1716144F4B464545441016
          1E02081101030AFF00FFFF00FFFF00FF1D688C1D688C1D688C1D688CFF00FFFF
          00FFFF00FFFF00FF38393941403E110F0C000000FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 0
        OnClick = btnLoginClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 173
      Top = 2
      Height = 21
      ParentFont = False
      ExplicitLeft = 173
      ExplicitTop = 2
      ExplicitHeight = 21
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 252
    Height = 123
    Align = alClient
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 11
      Top = 12
      Width = 42
      Height = 14
      Caption = 'Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 55
      Top = 12
      Width = 34
      Height = 14
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 11
      Top = 72
      Width = 49
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtLogin: TEditFocus
      Tag = 99
      Left = 11
      Top = 26
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSenha: TEditFocus
      Tag = 99
      Left = 55
      Top = 26
      Width = 181
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 11
      Top = 49
      Width = 225
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 11
      Top = 86
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 55
      Top = 86
      Width = 181
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 149
    Width = 252
    TabOrder = 2
    ExplicitTop = 149
    ExplicitWidth = 252
    inherited pnlNomeForm: TPanel
      Left = 148
      Width = 104
      ExplicitLeft = 148
      ExplicitWidth = 104
    end
    inherited pnlInfo: TPanel
      Width = 148
      ExplicitWidth = 148
    end
  end
end
