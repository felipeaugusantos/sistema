inherited frmRcxResumoCaixa: TfrmRcxResumoCaixa
  Left = 206
  Top = 113
  Width = 727
  Height = 596
  BorderIcons = [biSystemMenu]
  Caption = 'Resumo de Caixa'
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 727
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 418
    Width = 721
    Height = 133
    BevelInner = bvNone
    BevelOuter = bvNone
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 418
    ExplicitWidth = 721
    ExplicitHeight = 133
    DesignSize = (
      721
      133)
    inherited FlwBotoes: TFlowPanel
      AlignWithMargins = True
      Top = 1
      Width = 719
      Height = 132
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      ExplicitTop = 1
      ExplicitWidth = 719
      ExplicitHeight = 132
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 142
        Height = 22
        Caption = '&Gravar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnGravarClick
      end
      object btnFormaPagamento: TBitBtnLocked
        Left = 142
        Top = 0
        Width = 142
        Height = 22
        Caption = '[F3] Forma Pag.'
        TabOrder = 1
        OnClick = btnFormaPagamentoClick
      end
      object btnCancFec: TBitBtnLocked
        Left = 284
        Top = 0
        Width = 142
        Height = 22
        Caption = '[ F4 ] Canc. Fec.'
        TabOrder = 2
        OnClick = btnCancFecClick
      end
      object btnDepoCheque: TBitBtnLocked
        Left = 426
        Top = 0
        Width = 142
        Height = 22
        Caption = '[ F5 ] Dep. Cheques'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnDepoChequeClick
      end
      object btnHisDeb: TBitBtnLocked
        Left = 568
        Top = 0
        Width = 142
        Height = 22
        Caption = '[ F6 ] C./C.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnHisDebClick
      end
      object btnFecharCaixa: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 142
        Height = 22
        Caption = '[ F7 ] Fechar Caixa'
        TabOrder = 5
        OnClick = btnFecharCaixaClick
      end
      object btnConfirmaCupons: TBitBtnLocked
        Left = 142
        Top = 22
        Width = 142
        Height = 22
        Caption = '[ F8 ] Conf. Cupons'
        TabOrder = 6
        OnClick = btnConfirmaCuponsClick
      end
      object btnBaixaCtaPagar: TBitBtnLocked
        Left = 284
        Top = 22
        Width = 142
        Height = 22
        Caption = '[ F9 ] Baixa. Ct. Pag.'
        TabOrder = 7
        OnClick = btnBaixaCtaPagarClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 426
        Top = 22
        Width = 142
        Height = 22
        Caption = '[ F10 ] Relat'#243'rio'
        PopupMenu = mnuRelatorio
        TabOrder = 8
        OnClick = btnRelatorioClick
      end
      object btnConfOrcamentos: TBitBtnLocked
        Left = 568
        Top = 22
        Width = 142
        Height = 22
        Caption = '[ F11 ] Conf. Or'#231'.'
        PopupMenu = mnuRelatorio
        TabOrder = 9
        OnClick = btnConfOrcamentosClick
      end
      object btnAbreGaveta: TBitBtnLocked
        Left = 0
        Top = 44
        Width = 142
        Height = 22
        Caption = '[ F12 ] Abre Gaveta'
        PopupMenu = mnuRelatorio
        TabOrder = 10
        OnClick = btnAbreGavetaClick
      end
      object btnLiberacao: TBitBtnLocked
        Left = 142
        Top = 44
        Width = 142
        Height = 22
        Caption = '[ALT+L] Libera'#231#227'o'
        PopupMenu = mnuRelatorio
        TabOrder = 11
        OnClick = btnLiberacaoClick
      end
      object btnAtalhos: TBitBtnLocked
        Left = 284
        Top = 44
        Width = 142
        Height = 22
        Caption = '[ALT+T] Estornos'
        PopupMenu = popEstornos
        TabOrder = 12
        OnClick = btnAtalhosClick
      end
      object btnRomaneio: TBitBtnLocked
        Left = 426
        Top = 44
        Width = 142
        Height = 22
        Caption = '[ ALT+R ] Romaneio'
        Enabled = False
        PopupMenu = mnuRelatorio
        TabOrder = 13
        OnClick = btnRomaneioClick
      end
      object btnTitRec: TBitBtnLocked
        Left = 568
        Top = 44
        Width = 142
        Height = 22
        Caption = '[Alt+F3] Tit. Receber'
        TabOrder = 14
        OnClick = btnTitRecClick
      end
      object btnAutTR: TBitBtnLocked
        Left = 0
        Top = 66
        Width = 142
        Height = 22
        Hint = 'Atutentica'#231#227'o TR/DV'
        Caption = '[ALT+A] Aut. TR/DV'
        PopupMenu = mnuRelatorio
        TabOrder = 15
        OnClick = btnAutTRClick
      end
      object btnBaixaEntFutura: TBitBtnLocked
        Left = 142
        Top = 66
        Width = 142
        Height = 22
        Hint = 'Baixa de Entrega Futura'
        Caption = '[ALT+B] Bx. Ent. Fut.'
        ParentShowHint = False
        PopupMenu = mnuRelatorio
        ShowHint = True
        TabOrder = 16
        OnClick = btnBaixaEntFuturaClick
      end
      object btnAcompanhaServ: TBitBtnLocked
        Left = 284
        Top = 66
        Width = 142
        Height = 22
        Caption = '[ALT+F2] Acp. Serv.'
        TabOrder = 17
        OnClick = btnAcompanhaServClick
      end
      object btnCapturarGT: TBitBtnLocked
        Left = 426
        Top = 66
        Width = 142
        Height = 22
        Caption = '[Alt+C] Capturar GT'
        PopupMenu = mnuRelatorio
        TabOrder = 18
        OnClick = btnCapturarGTClick
      end
      object btnFatPromocaoBrindes: TBitBtnLocked
        Left = 568
        Top = 66
        Width = 142
        Height = 22
        Caption = '[Ctrl+P] Prom. Brindes'
        PopupMenu = mnuRelatorio
        TabOrder = 19
        OnClick = btnFatPromocaoBrindesClick
      end
      object btnConfCupSimplificada: TBitBtnLocked
        Left = 0
        Top = 88
        Width = 142
        Height = 22
        Hint = 
          'Confirma'#231#227'o de Cupom Simplificada - Esta rotina ir'#225' confirmar o ' +
          'Cupom em uma Nota Fiscal'
        Caption = '[ALT+F] Confirm. IF'
        ParentShowHint = False
        PopupMenu = mnuRelatorio
        ShowHint = True
        TabOrder = 20
        OnClick = btnConfCupSimplificadaClick
        OnEnter = btnConfCupSimplificadaEnter
        OnExit = btnConfCupSimplificadaExit
      end
      object btnConfFFSimplificada: TBitBtnLocked
        Left = 142
        Top = 88
        Width = 142
        Height = 22
        Hint = 
          'Confirma'#231#227'o de FF Simplificada - Esta rotina ir'#225' confirmar FF em' +
          ' uma Nota Fiscal ou Cupom Fiscal (caso utilize)'
        Caption = '[CTRL+F] Confirm. FF'
        ParentShowHint = False
        PopupMenu = mnuRelatorio
        ShowHint = True
        TabOrder = 21
        OnClick = btnConfFFSimplificadaClick
        OnEnter = btnConfFFSimplificadaEnter
        OnExit = btnConfFFSimplificadaExit
      end
      object btnInfDoc: TBitBtnLocked
        Left = 284
        Top = 88
        Width = 142
        Height = 22
        Caption = '[ALT+D] Inf Docume.'
        PopupMenu = mnuRelatorio
        TabOrder = 22
        OnClick = btnInfDocClick
      end
      object btnImprDAV: TBitBtnLocked
        Left = 426
        Top = 88
        Width = 142
        Height = 22
        Caption = '[ALT+V] DAV'
        PopupMenu = mnuRelatorio
        TabOrder = 23
        OnClick = btnImprDAVClick
      end
      object btnAdiantamento: TBitBtnLocked
        Left = 568
        Top = 88
        Width = 142
        Height = 22
        Caption = '[Ctrl+A] Adiantamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 24
        OnClick = btnAdiantamentoClick
      end
      object btnRelAltFormaPag: TBitBtnLocked
        Left = 0
        Top = 110
        Width = 142
        Height = 22
        Hint = 'Relat'#243'rio de Altera'#231#227'o de Forma de Pagamento'
        Caption = '[ALT+H] Rel. Alt. Forma Pag.'
        ParentShowHint = False
        PopupMenu = mnuRelatorio
        ShowHint = True
        TabOrder = 25
        OnClick = btnRelAltFormaPagClick
      end
      object btnCancelaCC: TBitBtnLocked
        Left = 142
        Top = 110
        Width = 142
        Height = 22
        Hint = 
          'Cancela lan'#231'amentos de cr'#233'dito para cliente (CC) feitos pelo res' +
          'umo de caixa'
        Caption = '[CTRL+R] Cancela CC'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 26
        OnClick = btnCancelaCCClick
      end
      object btnEntFutCD: TBitBtnLocked
        Left = 284
        Top = 110
        Width = 142
        Height = 22
        Caption = '[Ctrl+E] Ent.Fut.pelo CD'
        PopupMenu = mnuRelatorio
        TabOrder = 27
        OnClick = btnEntFutCDClick
      end
      object btnLeituraX: TBitBtnLocked
        Left = 426
        Top = 110
        Width = 142
        Height = 22
        Caption = '[Ctrl+L] Leitura X'
        TabOrder = 28
        OnClick = btnLeituraXClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 570
      Top = 111
      Width = 142
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 570
      ExplicitTop = 111
      ExplicitWidth = 142
    end
  end
  inherited pnlStatus: TPanel
    Top = 551
    Width = 721
    TabOrder = 2
    ExplicitTop = 551
    ExplicitWidth = 721
    inherited pnlNomeForm: TPanel
      Left = 599
      Width = 122
      ExplicitLeft = 599
      ExplicitWidth = 122
    end
    inherited pnlInfo: TPanel
      Width = 599
      ExplicitWidth = 599
    end
  end
  inherited pgcDados: TPageControl
    Width = 721
    Height = 418
    TabOrder = 3
    TabStop = False
    ExplicitWidth = 721
    ExplicitHeight = 418
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 713
      ExplicitHeight = 386
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 721
    Height = 418
    Align = alClient
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 719
      Height = 67
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        719
        67)
      object Label1: TLabel
        Left = 18
        Top = 15
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador:'
      end
      object Label2: TLabel
        Left = 181
        Top = 38
        Width = 84
        Height = 14
        Caption = 'Referente ao Dia:'
      end
      object Label3: TLabel
        Left = 8
        Top = 38
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Inicial:'
      end
      object Label21: TLabel
        Left = 346
        Top = 38
        Width = 120
        Height = 14
        Caption = 'Seq. fechamento parcial:'
      end
      object lblCaixa: TLabel
        Left = 381
        Top = 14
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Caixa Atual:'
      end
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 69
        Top = 11
        Width = 55
        Height = 22
        TabStop = False
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
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomOpe: TEditFocus
        Left = 124
        Top = 11
        Width = 216
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
      object mskDiaAbe: TMaskEdit
        Left = 267
        Top = 34
        Width = 73
        Height = 22
        TabStop = False
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ReadOnly = True
        TabOrder = 3
        Text = '  /  /    '
      end
      object edtSalIni: TEditFocus
        Tag = 99
        Left = 69
        Top = 34
        Width = 90
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSqFcRx: TEditFocus
        Tag = 99
        Left = 472
        Top = 34
        Width = 28
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodigoCaixa: TEditFocus
        Tag = 99
        Left = 444
        Top = 11
        Width = 55
        Height = 22
        TabStop = False
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
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDescricaoCaixa: TEditFocus
        Left = 499
        Top = 11
        Width = 212
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDocumento: TPanel
      Left = 1
      Top = 68
      Width = 719
      Height = 244
      Align = alClient
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        719
        244)
      object lblValRec: TLabel
        Left = 39
        Top = 188
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object Label7: TLabel
        Left = 15
        Top = 210
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object lblNomMoe: TLabel
        Left = 183
        Top = 184
        Width = 114
        Height = 18
        Caption = 'EM GUARANIES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblCredito: TLabel
        Left = 482
        Top = 185
        Width = 106
        Height = 16
        Caption = 'CR'#201'DITO R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblVrRestante: TLabel
        Left = 310
        Top = 185
        Width = 124
        Height = 16
        Caption = 'Vr. Restante R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object edtValDoc: TEditFocus
        Tag = 99
        Left = 69
        Top = 184
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 1
        OnEnter = edtDescriEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDescri: TEditFocus
        Tag = 99
        Left = 69
        Top = 207
        Width = 642
        Height = 22
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 50
        ParentFont = False
        TabOrder = 2
        OnEnter = edtDescriEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pgcDadosGerais: TPageControl
        Left = 1
        Top = 1
        Width = 717
        Height = 182
        ActivePage = tbsRecebimentos
        Align = alTop
        Style = tsFlatButtons
        TabOrder = 0
        StyleElements = [seBorder]
        OnChange = pgcDadosGeraisChange
        OnChanging = pgcDadosGeraisChanging
        object tbsLancamentos: TTabSheet
          Tag = -1
          Caption = '[ F1 ] Lan'#231'amentos'
          OnShow = tbsLancamentosShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          DesignSize = (
            709
            150)
          object Label5: TLabel
            Left = 166
            Top = 9
            Width = 57
            Height = 14
            Caption = 'Documento:'
          end
          object lblClienteCC: TLabel
            Left = 27
            Top = 105
            Width = 35
            Height = 14
            Caption = 'Cliente:'
            Visible = False
          end
          object edtNumDoc: TEditFocus
            Tag = 99
            Left = 227
            Top = 5
            Width = 142
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
            MaxLength = 12
            ParentFont = False
            TabOrder = 1
            OnEnter = edtDescriEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttNumerico
          end
          object lsvLancamentos: TListView
            Left = 0
            Top = 0
            Width = 164
            Height = 99
            Columns = <
              item
                Caption = 'Esp.'
              end
              item
                Caption = 'Descri'#231#227'o'
                Width = 92
              end>
            ColumnClick = False
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnEnter = lsvLancamentosEnter
            OnKeyDown = lsvLancamentosKeyDown
          end
          object edtDesOpc: TEditFocus
            Left = 166
            Top = 28
            Width = 540
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Anchors = [akLeft, akTop, akRight]
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtClienteCC: TEditFocus
            Tag = 99
            Left = 64
            Top = 101
            Width = 642
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Anchors = [akLeft, akTop, akRight]
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 50
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            Visible = False
            OnEnter = edtDescriEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object chkSaldoInicial: TCheckBox
            Left = 385
            Top = 8
            Width = 230
            Height = 17
            Caption = 'Lan'#231'amento de Cr'#233'dito para Saldo inicial'
            TabOrder = 2
            Visible = False
          end
        end
        object tbsRecebimentos: TTabSheet
          Tag = -1
          Caption = '[ F2 ] Recebimentos'
          ImageIndex = 1
          OnShow = tbsRecebimentosShow
          object Label15: TLabel
            Left = 27
            Top = 35
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cliente:'
          end
          object Label16: TLabel
            Left = 8
            Top = 104
            Width = 54
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Inicial:'
          end
          object Label17: TLabel
            Left = 158
            Top = 105
            Width = 78
            Height = 14
            Caption = '(VENCIMENTO)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label18: TLabel
            Left = 12
            Top = 130
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Final:'
          end
          object Label19: TLabel
            Left = 158
            Top = 129
            Width = 78
            Height = 14
            Caption = '(VENCIMENTO)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblRomaneio: TLabel
            Left = 12
            Top = 12
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'Romaneio:'
            Visible = False
          end
          object lblEmpresa: TLabel
            Left = 17
            Top = 81
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object btnBusContrato: TSpeedButton
            Left = 485
            Top = 9
            Width = 151
            Height = 22
            Caption = '[Alt + B] &Buscar Contrato'
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
              83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
              DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
              AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
              00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
              E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
              0066000066000066000066000066000066000066000066000066000066000066
              00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
              3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
              0066000066000066000066000066000066000066000066000066000066000066
              00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
              ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
              CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
              00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
              F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
              0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
              D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
              2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
              43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
              DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
              FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
              0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
              82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            OnClick = btnBusContratoClick
          end
          object btnCancelamentoPDV: TSpeedButton
            Left = 166
            Top = 10
            Width = 291
            Height = 21
            Caption = 'Clique aqui para concluir o cancelamento do PDV'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
            OnClick = btnCancelamentoPDVClick
          end
          object Label6: TLabel
            Left = 5
            Top = 58
            Width = 57
            Height = 14
            Alignment = taRightJustify
            Caption = 'Rede Lojas:'
          end
          object edtCodCli: TEditFocus
            Tag = 99
            Left = 64
            Top = 32
            Width = 90
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
            MaxLength = 8
            ParentFont = False
            TabOrder = 1
            OnChange = edtCodCliChange
            OnEnter = edtDescriEnter
            OnExit = edtCodCliExit
            OnKeyPress = edtCodCliKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtNomCli: TEditFocus
            Left = 155
            Top = 32
            Width = 481
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 2
            OnEnter = edtDescriEnter
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtRomaneio: TEditFocus
            Tag = 99
            Left = 64
            Top = 9
            Width = 90
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 6
            ParentFont = False
            TabOrder = 0
            Visible = False
            OnChange = edtRomaneioChange
            OnExit = edtRomaneioExit
            OnKeyPress = edtRomaneioKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttNumerico
          end
          object edtCodEmp: TEditFocus
            Left = 64
            Top = 78
            Width = 90
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
            TabOrder = 5
            OnExit = edtCodEmpExit
            OnKeyPress = edtCodEmpKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesEmp: TEditFocus
            Left = 155
            Top = 78
            Width = 481
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 6
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object chkDuplicatasVista: TCheckBox
            Left = 240
            Top = 104
            Width = 193
            Height = 17
            Caption = 'Somente duplicatas a vista'
            Checked = True
            State = cbChecked
            TabOrder = 8
          end
          object edtCodRed: TEditFocus
            Tag = 99
            Left = 64
            Top = 55
            Width = 90
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 5
            TabOrder = 3
            OnKeyPress = edtCodRedKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttAlfanumerico
          end
          object edtDescRed: TEditFocus
            Left = 155
            Top = 55
            Width = 481
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 4
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskDtaIni: TcxDateEdit
            Tag = 99
            Left = 64
            Top = 101
            Properties.ButtonGlyph.SourceDPI = 96
            Properties.ButtonGlyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000000000020000000A0000
              0010000000110000001100000011000000120000001200000012000000120000
              00120000001300000013000000120000000C000000030000000A81594CC2B47C
              69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
              67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
              F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
              E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
              F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
              83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
              F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
              D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
              F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
              86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
              FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
              D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
              FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
              8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
              FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
              DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
              FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
              91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
              FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
              F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
              ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
              DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
              EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
              DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
              EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
              E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
              C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
              B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
              0006000000060000000600000007000000070000000700000007000000070000
              00070000000800000008000000070000000500000001}
            Properties.ClearKey = 46
            Properties.DateButtons = []
            Properties.MinDate = 2.000000000000000000
            Properties.ValidateOnEnter = False
            Properties.ValidationOptions = []
            Properties.OnValidate = cxDateEdit1PropertiesValidate
            StyleFocused.Color = clInfoBk
            TabOrder = 7
            Width = 90
          end
          object mskDtaFin: TcxDateEdit
            Tag = 99
            Left = 64
            Top = 126
            Properties.ButtonGlyph.SourceDPI = 96
            Properties.ButtonGlyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000000000020000000A0000
              0010000000110000001100000011000000120000001200000012000000120000
              00120000001300000013000000120000000C000000030000000A81594CC2B47C
              69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
              67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
              F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
              E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
              F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
              83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
              F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
              D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
              F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
              86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
              FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
              D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
              FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
              8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
              FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
              DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
              FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
              91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
              FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
              F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
              ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
              DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
              EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
              DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
              EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
              E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
              C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
              B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
              0006000000060000000600000007000000070000000700000007000000070000
              00070000000800000008000000070000000500000001}
            Properties.ClearKey = 46
            Properties.DateButtons = []
            Properties.MinDate = 2.000000000000000000
            Properties.ValidateOnEnter = False
            Properties.ValidationOptions = []
            Properties.OnValidate = cxDateEdit1PropertiesValidate
            StyleFocused.Color = clInfoBk
            TabOrder = 9
            Width = 90
          end
        end
      end
    end
    object pnlModalidades: TPanel
      Left = 1
      Top = 312
      Width = 719
      Height = 105
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label8: TLabel
        Left = 1
        Top = 1
        Width = 717
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'MODALIDADE(S)  DE PAGAMENTO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 214
      end
      object Label9: TLabel
        Left = 74
        Top = 36
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dinheiro:'
      end
      object Label10: TLabel
        Left = 81
        Top = 59
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cart'#227'o:'
      end
      object Label11: TLabel
        Left = 297
        Top = 36
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cheque a Vista:'
      end
      object Label12: TLabel
        Left = 315
        Top = 59
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cheque Pre:'
      end
      object Label13: TLabel
        Left = 591
        Top = 36
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Juros:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 572
        Top = 59
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 587
        Top = 82
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Troco:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 10
        Top = 82
        Width = 106
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ordem de Pagamento:'
      end
      object lblFinanc: TLabel
        Left = 303
        Top = 82
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Financiamento:'
        Visible = False
      end
      object edtDinRec: TEditFocus
        Tag = 99
        Left = 117
        Top = 32
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 0
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCarRec: TEditFocus
        Tag = 99
        Left = 117
        Top = 55
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 1
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtChqRec: TEditFocus
        Tag = 99
        Left = 376
        Top = 32
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 2
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtChqPre: TEditFocus
        Tag = 99
        Left = 376
        Top = 55
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 3
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValJur: TEditFocus
        Tag = 99
        Left = 624
        Top = 32
        Width = 85
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValDes: TEditFocus
        Tag = 99
        Left = 624
        Top = 55
        Width = 85
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTroco: TEditFocus
        Tag = 99
        Left = 624
        Top = 78
        Width = 85
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        AutoSize = False
        CharCase = ecUpperCase
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        OnChange = edtTrocoChange
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtOrdRec: TEditFocus
        Tag = 99
        Left = 117
        Top = 78
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 4
        OnChange = edtOrdRecChange
        OnEnter = edtDinRecEnter
        OnExit = edtDinRecExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtFinanc: TEditFocus
        Tag = 99
        Left = 376
        Top = 78
        Width = 108
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        ParentFont = False
        TabOrder = 9
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnReceberPix: TBitBtnLocked
        Left = 228
        Top = 78
        Width = 31
        Height = 22
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000002124003068710098757F00AC262A
          0038000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000001A1C0026A7B600F5AEBD00FFAEBD00FFA3B1
          00EF373B00500000000000000000000000000000000000000000000000000000
          0000000000000000000021240030A7B600F5AEBD00FFAEBD00FFAEBD00FFAEBD
          00FFA3B100EF373B005000000000000000000000000000000000000000000000
          0000000000001B1E00289CAA00E5AEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD
          00FFAEBD00FFA3B100EF262A0038000000000000000000000000000000000000
          0000212400304C5300703A3F005568710099AEBD00FFAEBD00FFAEBD00FFAEBD
          00FF8D9900CF373C00514A50006C2F3300450000000000000000000000002124
          0030A7B600F5AEBD00FFAEBD00FF6068008C6069008DAEBD00FFAEBD00FF8D99
          00CF272A0039AEBD00FFAEBD00FFA3B100EF373B0050000000001416001EA3B1
          00EFAEBD00FFAEBD00FFAEBD00FFAEBD00FF5D6600895D6600898D9900CF363B
          004FADBC00FEAEBD00FFAEBD00FFAEBD00FFA3B100EF2C300041626A008FAEBD
          00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF6A74009C444A0064ADBC
          00FEAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF7B8500B458600081AEBD
          00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF626B00904E550073A3B1
          00EFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF768000AD1B1E0028A3B1
          00EFAEBD00FFAEBD00FFAEBD00FFAEBD00FF545B007B677000978D9900CE383D
          0052A3B100EFAEBD00FFAEBD00FFAEBD00FFAEBD00FF272A0039000000002124
          0030A3B100EFAEBD00FFAEBD00FF565D007E68710099AEBD00FFAEBD00FF8D99
          00CF383D0052A3B100EFAEBD00FFAEBD00FF3034004600000000000000000000
          0000212400304C530070373B0050646D0093AEBD00FFAEBD00FFAEBD00FFAEBD
          00FF8D9900CF4146005F4A50006C212400300000000000000000000000000000
          00000000000016180020A3B100EFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD
          00FFAEBD00FF9EAC00E8262A0038000000000000000000000000000000000000
          0000000000000000000021240030A3B100EFAEBD00FFAEBD00FFAEBD00FFAEBD
          00FFAEBD00FF2C2F004000000000000000000000000000000000000000000000
          0000000000000000000000000000212400309CAA00E5AEBD00FFAEBD00FFAEBD
          00FF2C2F00400000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000021240030636B0091778200AF1E21
          002C000000000000000000000000000000000000000000000000}
        TabOrder = 5
        OnClick = btnReceberPixClick
      end
      object chkPixAvulso: TCheckBox
        Left = 264
        Top = 81
        Width = 73
        Height = 17
        Alignment = taLeftJustify
        BiDiMode = bdLeftToRight
        Caption = 'Pix Avulso:'
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 10
        OnClick = chkPixAvulsoClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 64
  end
  object mnuRelatorio: TPopupMenu
    Left = 455
    Top = 64
    object mnuRelatorio1: TMenuItem
      Caption = 'Relat'#243'rio'
    end
    object mnuRomaneio: TMenuItem
      Caption = 'Romaneio'
    end
  end
  object popEstornos: TPopupMenu
    Left = 488
    Top = 64
    object btnEstorno: TMenuItem
      Caption = '[ALT + E] Estorno CTR'
      OnClick = btnEstornoClick
    end
    object btnEstornoPG: TMenuItem
      Caption = '[ALT + P] Estorno PG'
      OnClick = btnEstornoPGClick
    end
  end
  object tmrCancelamentos: TTimer
    Interval = 60000
    OnTimer = tmrCancelamentosTimer
    Left = 432
    Top = 176
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -12
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = []
    HintStyle.IconType = cxhiInformation
    HintStyle.Rounded = True
    Left = 522
    Top = 176
  end
end
