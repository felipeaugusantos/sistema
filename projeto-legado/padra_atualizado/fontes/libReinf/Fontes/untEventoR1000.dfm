inherited frmEventoR1000: TfrmEventoR1000
  Width = 873
  Height = 500
  BorderStyle = bsNone
  Caption = 'R1000'
  KeyPreview = False
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 873
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 456
    Width = 873
    TabOrder = 3
    Visible = False
    ExplicitTop = 456
    ExplicitWidth = 873
    inherited FlwBotoes: TFlowPanel
      Width = 869
      ExplicitWidth = 869
    end
    inherited btnSair: TBitBtnLocked
      Left = 793
      Visible = False
      ExplicitLeft = 793
    end
  end
  inherited pnlStatus: TPanel
    Top = 484
    Width = 873
    TabOrder = 2
    Visible = False
    ExplicitTop = 484
    ExplicitWidth = 873
    inherited pnlNomeForm: TPanel
      Left = 702
      Visible = False
      ExplicitLeft = 702
    end
    inherited pnlInfo: TPanel
      Width = 702
      Visible = False
      ExplicitWidth = 702
    end
  end
  object pnlInferior: TPanel [2]
    Left = 0
    Top = 423
    Width = 873
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnGravarR1000: TBitBtnLocked
      Left = 5
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Gravar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000562D
        4580AB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FF562D45800000000000000000AB59
        89FFAB5989FFAB5989FFFFFFFEFFFFFFFEFFAB5989FFAB5989FFFFFFFEFFFFFF
        FEFFFFFFFEFFFFFFFEFFAB5989FFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFAB5989FFFFFFFEFFFFFFFEFFAB5989FFAB5989FFFFFFFEFFFFFF
        FEFFFFFFFEFFFFFFFEFFAB5989FFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFAB5989FFFFFFFEFFFFFFFEFFAB5989FFAB5989FFFFFFFEFFFFFF
        FEFFFFFFFEFFFFFFFEFFAB5989FFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFAB5989FFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFF
        FEFFFFFFFEFFFFFFFEFFAB5989FFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFFFFFFFFFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
        C1FFC1C1C1FFFFFFFFFFFFFFFFFFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFFFFFFFFFFFFFFFFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
        C1FFC1C1C1FFFFFFFFFFFFFFFFFFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFAB5989FFAB5989FF0000000000000000AB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FFAB59
        89FFAB5989FFAB5989FFAB5989FFAB5989FFAB5989FF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 0
      OnClick = btnGravarR1000Click
    end
    object btnTransmitirR1000: TBitBtnLocked
      Left = 85
      Top = 6
      Width = 102
      Height = 25
      Caption = 'Transmitir'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000000000008484
        84FF848484FF848484FF848484FF000000000000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000848484FF8484
        84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000848484FF0000
        0000848484FF848484FF00000000848484FF0000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        0000B8824DFF00000000B8824DFFB8824DFF00000000B8824DFF000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        0000B8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        000000000000B8824DFFB8824DFFB8824DFFB8824DFF00000000000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        00000000000000000000B8824DFFB8824DFF0000000000000000000000000000
        0000848484FF848484FF00000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 1
      OnClick = btnTransmitirR1000Click
    end
    object btnBaixarXmlEnvio: TBitBtnLocked
      Left = 192
      Top = 6
      Width = 140
      Height = 25
      Caption = 'Baixar XML Envio'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF848484FF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF97A776FF97A7
        76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
        76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFFFFFFFFFFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFFCBD3BAFFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFCBD3
        BAFFFFFFFFFFCBD3BAFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFFCBD3BAFFFFFFFFFF97A776FFFFFFFFFFFFFFFFFFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FF97A7
        76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
        76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF848484FF848484FF}
      TabOrder = 2
      OnClick = btnBaixarXmlEnvioClick
    end
    object btnBaixarXmlRetorno: TBitBtnLocked
      Left = 337
      Top = 6
      Width = 140
      Height = 25
      Caption = 'Baixar XML Retorno'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF848484FF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF97A776FF97A7
        76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
        76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFFFFFFFFFFFFFFFFFF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFFCBD3BAFFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFCBD3
        BAFFFFFFFFFFCBD3BAFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFFCBD3BAFFFFFFFFFF97A776FFFFFFFFFFFFFFFFFFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FFFFFF
        FFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFFFFFF97A776FFFFFF
        FFFF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF97A776FF97A7
        76FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A776FF97A7
        76FF97A776FF97A776FF97A776FFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF000000000000
        00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF848484FF848484FF}
      TabOrder = 3
      OnClick = btnBaixarXmlRetornoClick
    end
    object btnConsultaLote: TBitBtnLocked
      Left = 482
      Top = 6
      Width = 173
      Height = 25
      Caption = 'Reprocessar Lote'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000008484
        84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF848484FF848484FF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F5F0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8D7C6FFBB8855FFEADACAFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFE8D7C6FFBA8551FFB8824DFFBA8551FFEBDB
        CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFFFFFFFFFE8D7C6FFBA8551FFB8824DFFB8824DFFB8824DFFBA85
        52FFEBDCCDFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFE8D6C5FFBA8551FFB8824DFFBB8754FFDDC3A9FFBA8653FFB882
        4DFFBA8552FFEBDCCDFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
        84FFFCFBF9FFC19365FFB8824DFFBB8754FFEDE0D2FFFFFFFFFFEBDCCDFFBA86
        53FFB8824DFFBA8552FFEBDBCCFFFFFFFFFF848484FF00000000000000008484
        84FFFFFFFFFFF5EEE7FFC39568FFEDE0D2FFFFFFFFFFFFFFFFFFFFFFFFFFEBDC
        CDFFBA8653FFB8824DFFBA8552FFEBDBCCFFFFFFFFFF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFEFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFEBDCCDFFBA8653FFB8824DFFBA8552FFEBDBCCFF00000000000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFEBDCCDFFBA8653FFB8824DFFBA8552FF35251649000000008484
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFEBDCCDFFBA8653FFB8824DFF90653CC7000000008484
        84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FFFFFFFFFFEBDCCDFFC89E75FF0D090512000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000101000100000000}
      TabOrder = 4
      Visible = False
      OnClick = btnConsultaLoteClick
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 873
    Height = 423
    BevelOuter = bvNone
    TabOrder = 0
    object lblClassTrib: TLabel
      Left = 3
      Top = 9
      Width = 116
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classifica'#231#227'o Tribut'#225'ria:'
    end
    object lblEscrituracao: TLabel
      Left = 5
      Top = 33
      Width = 323
      Height = 14
      Caption = 
        'Contribuinte obrigado em fazer a sua escritura'#231#227'o cont'#225'bil na EC' +
        'D:'
    end
    object lblDesoneracao: TLabel
      Left = 5
      Top = 57
      Width = 163
      Height = 14
      Caption = 'Desonera'#231#227'o da folha pela CPRB:'
    end
    object lblAcordo: TLabel
      Left = 5
      Top = 81
      Width = 212
      Height = 14
      Caption = 'Acordo internacional para isen'#231#227'o de multa:'
    end
    object lblSituacao: TLabel
      Left = 573
      Top = 33
      Width = 74
      Height = 14
      Caption = 'Situa'#231#227'o da PJ:'
    end
    object lblUniao: TLabel
      Left = 488
      Top = 57
      Width = 132
      Height = 14
      Caption = 'Entidade vinculada a Uni'#227'o:'
    end
    object shaErro: TShape
      Left = 818
      Top = 275
      Width = 25
      Height = 10
      Brush.Color = 8036607
      Pen.Style = psClear
    end
    object shaSucesso: TShape
      Left = 664
      Top = 275
      Width = 25
      Height = 10
      Brush.Color = 9498256
      Pen.Style = psClear
    end
    object lblErro: TLabel
      Left = 847
      Top = 272
      Width = 20
      Height = 14
      Caption = 'Erro'
    end
    object lblSucesso: TLabel
      Left = 694
      Top = 272
      Width = 107
      Height = 14
      Caption = 'Enviado com Sucesso'
    end
    object edtCodClassTrib: TEditFocus
      Tag = 99
      Left = 121
      Top = 6
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 0
      OnKeyPress = edtCodClassTribKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtClassTrib: TEditFocus
      Left = 186
      Top = 6
      Width = 683
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object cmbEscrituracao: TComboBoxFocus
      Tag = 99
      Left = 331
      Top = 30
      Width = 226
      Height = 22
      ItemIndex = 0
      TabOrder = 2
      Text = 'Empresa n'#227'o '#233' obrigada a entregar o ECD'
      Items.Strings = (
        'Empresa n'#227'o '#233' obrigada a entregar o ECD'
        'Empresa obrigada a entregar o ECD')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbDesoneracao: TComboBoxFocus
      Tag = 99
      Left = 169
      Top = 54
      Width = 300
      Height = 22
      ItemIndex = 0
      TabOrder = 3
      Text = 'N'#227'o Aplic'#225'vel'
      Items.Strings = (
        'N'#227'o Aplic'#225'vel'
        'Empresa Enquadrada nos Art. 7'#186' a 9'#186' da Lei 12.546/2011')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbAcordo: TComboBoxFocus
      Tag = 99
      Left = 219
      Top = 78
      Width = 90
      Height = 22
      ItemIndex = 0
      TabOrder = 4
      Text = 'Sem Acordo'
      Items.Strings = (
        'Sem Acordo'
        'Com Acordo')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbSituacao: TComboBoxFocus
      Tag = 99
      Left = 648
      Top = 30
      Width = 221
      Height = 22
      ItemIndex = 0
      TabOrder = 5
      Text = 'Normal'
      Items.Strings = (
        'Normal'
        'Extin'#231#227'o, fus'#227'o, cis'#227'o ou incorpora'#231#227'o'
        'Fus'#227'o, cis'#227'o ou incorpora'#231#227'o'
        'Cis'#227'o ou incorpora'#231#227'o'
        'Incorpora'#231#227'o')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbUniao: TComboBoxFocus
      Tag = 99
      Left = 622
      Top = 54
      Width = 247
      Height = 22
      ItemIndex = 0
      TabOrder = 6
      Text = 'N'#227'o Aplic'#225'vel'
      Items.Strings = (
        'N'#227'o Aplic'#225'vel'
        #211'rg'#227'o da administra'#231#227'o p'#250'blica federal direta')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object gpbInfoContato: TGroupBox
      Left = 5
      Top = 105
      Width = 863
      Height = 81
      Caption = 'Informa'#231#245'es de Contato'
      TabOrder = 7
      object lblNomCtt: TLabel
        Left = 67
        Top = 28
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object lblCpfCtt: TLabel
        Left = 391
        Top = 28
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'CPF:'
      end
      object lblFoneCtt: TLabel
        Left = 522
        Top = 28
        Width = 27
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fone:'
      end
      object lblCelCtt: TLabel
        Left = 658
        Top = 28
        Width = 18
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cel:'
      end
      object lblEmailCtt: TLabel
        Left = 65
        Top = 52
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'e-mail:'
      end
      object edtNomCtt: TEditFocus
        Tag = 99
        Left = 100
        Top = 25
        Width = 276
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 67
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskCpfCtt: TMaskEditC_G_C_
        Tag = 99
        Left = 416
        Top = 25
        Width = 89
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999.999-99;0;'
        MaxLength = 14
        TabOrder = 1
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtEmaCtt: TEditFocus
        Tag = 99
        Left = 100
        Top = 49
        Width = 405
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecLowerCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 255
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskTelCtt: TMaskEditFocus
        Tag = 99
        Left = 552
        Top = 25
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        EditMask = '(99)9999-9999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 13
        TabOrder = 2
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskCelCtt: TMaskEditFocus
        Tag = 99
        Left = 679
        Top = 25
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        EditMask = '(99)9.9999-9999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 15
        TabOrder = 3
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object gpbRetornoR1000: TGroupBox
      Left = 5
      Top = 212
      Width = 863
      Height = 60
      Caption = 'Retorno Envio'
      TabOrder = 8
      object cxgRetornoR1000: TcxGridCitel
        Left = 2
        Top = 16
        Width = 859
        Height = 42
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgRetornoR1000DBTableViewCitel1: TcxGridDBTableViewCitel
          OnDblClick = cxgRetornoR1000DBTableViewCitel1DblClick
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgRetornoR1000DBTableViewCitel1CustomDrawCell
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgRetornoLOT_CODRET: TcxGridDBColumn
            DataBinding.FieldName = 'LOT_CODRET'
            Visible = False
          end
          object cxgRetornoLOT_DTAENV: TcxGridDBColumn
            Caption = 'Data Envio'
            DataBinding.FieldName = 'LOT_DTAENV'
            Width = 74
          end
          object cxgRetornoLOT_PROTOC: TcxGridDBColumn
            Caption = 'Protocolo Envio'
            DataBinding.FieldName = 'LOT_PROTOC'
            Width = 143
          end
          object cxgRetornoLOT_DESRET: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Retorno'
            DataBinding.FieldName = 'LOT_DESRET'
            Width = 251
          end
          object cxgRetornoLOT_IDEEVE: TcxGridDBColumn
            Caption = 'ID Evento'
            DataBinding.FieldName = 'LOT_IDEEVE'
            Width = 186
          end
          object cxgRetornoLOT_RECIBO: TcxGridDBColumn
            Caption = 'N'#250'mero Recibo'
            DataBinding.FieldName = 'LOT_RECIBO'
            Width = 203
          end
        end
        object cxgRetornoR1000Level1: TcxGridLevel
          GridView = cxgRetornoR1000DBTableViewCitel1
        end
      end
    end
    object btnCadManual: TBitBtnLocked
      Left = 7
      Top = 272
      Width = 164
      Height = 25
      Caption = 'Cadastrar N'#250'mero do Recibo'
      TabOrder = 9
      Visible = False
      OnClick = btnCadManualClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1088
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1040
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 968
    Top = 136
  end
  object SaveDialog: TSaveDialog
    Left = 768
    Top = 360
  end
  object tmrConsultarProcessamento: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrConsultarProcessamentoTimer
    Left = 592
    Top = 360
  end
end
