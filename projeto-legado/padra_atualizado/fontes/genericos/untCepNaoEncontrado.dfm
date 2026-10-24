inherited frmCepNaoEncontrado: TfrmCepNaoEncontrado
  Width = 711
  Height = 384
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 711
  ExplicitHeight = 384
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 705
    Height = 0
    Visible = False
    ExplicitTop = 351
    ExplicitWidth = 705
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 701
      Height = 4
      ExplicitWidth = 701
      ExplicitHeight = 4
    end
    inherited btnSair: TBitBtnLocked
      Left = 625
      Top = -25
      ExplicitLeft = 625
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 351
    Width = 705
    Height = 4
    Visible = False
    ExplicitTop = 351
    ExplicitWidth = 705
    ExplicitHeight = 4
    inherited pnlNomeForm: TPanel
      Left = 534
      Height = 4
      ExplicitLeft = 534
      ExplicitHeight = 4
    end
    inherited pnlInfo: TPanel
      Width = 534
      Height = 4
      ExplicitWidth = 534
      ExplicitHeight = 4
    end
    inherited pnlBotoesTrace: TPanel
      Height = 4
      ExplicitHeight = 4
      inherited btnIniciarTrace: TSpeedButton
        Height = 4
        ExplicitHeight = 4
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 4
        ExplicitHeight = 4
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 4
        ExplicitHeight = 4
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 4
        ExplicitHeight = 4
      end
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 705
    Height = 351
    Align = alClient
    ParentBackground = False
    TabOrder = 2
    object pnlMensagem: TPanel
      Left = 1
      Top = 31
      Width = 703
      Height = 280
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblMensagem: TLabel
        Left = 2
        Top = 7
        Width = 698
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = 'Cep n'#227'o encontrado!'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = 20
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label1: TLabel
        Left = 0
        Top = 41
        Width = 700
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Clique no link abaixo para verificar se o cep existe nos correio' +
          's:'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label3: TLabel
        Left = 2
        Top = 149
        Width = 698
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Clique no link abaixo para descobrir o cep no site dos correios:'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object lblDescobrirCep: TLabel
        Left = 120
        Top = 177
        Width = 400
        Height = 16
        Cursor = crHandPoint
        Alignment = taCenter
        Caption = 'https://www2.correios.com.br/sistemas/buscacep/buscaCep.cfm'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = lblLinkCepExisteClick
      end
      object lblLinkCepExiste: TLabel
        Left = 130
        Top = 67
        Width = 435
        Height = 16
        Cursor = crHandPoint
        Alignment = taCenter
        Caption = 'https://www2.correios.com.br/sistemas/buscacep/buscaEndereco.cfm'
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = lblLinkCepExisteClick
      end
      object btnComoConsultarCepCorreios: TBitBtnLocked
        Left = 46
        Top = 100
        Width = 200
        Height = 33
        Caption = 'Como consultar cep nos Correios?'
        TabOrder = 0
        OnClick = btnComoConsultarCepCorreiosClick
      end
      object btnComoCorrigirCepAutcom: TBitBtnLocked
        Left = 464
        Top = 100
        Width = 200
        Height = 33
        Caption = 'Como corrigir cep no Autcom?'
        TabOrder = 1
        OnClick = btnComoCorrigirCepAutcomClick
      end
      object btnComoConsultarEndereco: TBitBtnLocked
        Left = 180
        Top = 207
        Width = 353
        Height = 33
        Caption = 'Como consultar cep nos correios de um determinado endere'#231'o?'
        TabOrder = 2
        OnClick = btnComoConsultarEnderecoClick
      end
      object Panel2: TPanel
        Left = 1
        Top = 249
        Width = 701
        Height = 30
        Align = alBottom
        Color = clNavy
        ParentBackground = False
        TabOrder = 3
        object Label5: TLabel
          Left = 1
          Top = 1
          Width = 699
          Height = 28
          Align = alClient
          Alignment = taCenter
          Caption = 'Deseja continuar mesmo assim?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = 19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 248
          ExplicitHeight = 19
        end
      end
    end
    object pblTitulo: TPanel
      Left = 1
      Top = 1
      Width = 703
      Height = 30
      Align = alTop
      Color = clNavy
      ParentBackground = False
      TabOrder = 1
      object lblTitulo: TLabel
        Left = 1
        Top = 1
        Width = 701
        Height = 28
        Align = alClient
        Alignment = taCenter
        Caption = 'Aten'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = 19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 63
        ExplicitHeight = 19
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 311
      Width = 703
      Height = 39
      Align = alBottom
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object btnSim: TBitBtnLocked
        Left = 193
        Top = 4
        Width = 150
        Height = 31
        Caption = '&Sim'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 18
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          1800000000000006000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF006600006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565656565FF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF0066001EB2311FB133006600FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6565659A9A9A9A9A9A65
          6565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00660031C24F22B7381AB02D21B437006600FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565ABABAB9E9E9E9797979C
          9C9C656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          00660047D36D3BCB5E25A83B0066001BA92E1DB132006600FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF656565BFBFBFB5B5B598989865656594
          9494999999656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006600
          4FD67953DE7F31B54D006600FF00FF006600179D271EAE31006600FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF656565C4C4C4CACACAA5A5A5656565FF00FF65
          65658C8C8C989898656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          00660041C563006600FF00FFFF00FFFF00FFFF00FF00660019AA2B006600FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF656565B5B5B5656565FF00FFFF00FFFF
          00FFFF00FF656565939393656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006600149D210066
          00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FF6565658A8A8A656565FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0066
          00006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF656565656565FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF006600006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565656565FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        OnClick = btnSimClick
      end
      object btnNao: TBitBtnLocked
        Left = 346
        Top = 4
        Width = 150
        Height = 31
        Caption = '&N'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 18
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00009A00009AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009A0000
          9AFF00FFFF00FFFF00FFFF00FFFF00FF00009A174AFD103BF400009AFF00FFFF
          00FFFF00FFFF00FF00009A002CF80030FC00009AFF00FFFF00FFFF00FFFF00FF
          00009A1A47F81A4CFF123BF100009AFF00FFFF00FF00009A012DF60132FF002A
          F300009AFF00FFFF00FFFF00FFFF00FFFF00FF00009A1C47F61B4DFF143EF400
          009A00009A002DF80134FF032BF200009AFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00009A1D48F61D50FF103DFB0431FE0132FF002CF600009AFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009A1A48F913
          42FF0C3CFF0733F600009AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00009A214EFC1D4BFF1847FF1743F600009AFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009A2E5BF92C5FFF22
          4DF8204BF82355FF1B46F600009AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00009A3664FA386BFF2D59F400009A00009A224CF42558FF1D49F60000
          9AFF00FFFF00FFFF00FFFF00FFFF00FF00009A4071FA4274FF325DF100009AFF
          00FFFF00FF00009A224DF1275AFF204CF800009AFF00FFFF00FFFF00FFFF00FF
          00009A497AFC3B66F300009AFF00FFFF00FFFF00FFFF00FF00009A2550F42655
          FA00009AFF00FFFF00FFFF00FFFF00FFFF00FF00009A00009AFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00009A00009AFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 1
        OnClick = btnNaoClick
      end
    end
  end
  object cxiImagem: TcxImage [3]
    Left = 28
    Top = 13
    AnimationOptions.Animation = bFalse
    AnimationOptions.AnimationLoop = bFalse
    Properties.GraphicClassName = 'TdxSmartImage'
    Properties.ImmediatePost = True
    Properties.PopupMenuLayout.MenuItems = []
    Properties.ReadOnly = True
    TabOrder = 3
    Visible = False
    Height = 51
    Width = 76
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 144
    Top = 16
  end
end
