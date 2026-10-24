inherited frmCadContratoLocEquip: TfrmCadContratoLocEquip
  Width = 830
  Height = 734
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Contratos de Loca'#231#227'o de Equipamentos'
  OnDestroy = FormDestroy
  ExplicitWidth = 830
  ExplicitHeight = 734
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 641
    Width = 824
    Height = 48
    TabOrder = 5
    ExplicitTop = 641
    ExplicitWidth = 824
    ExplicitHeight = 48
    inherited FlwBotoes: TFlowPanel
      Width = 820
      Height = 44
      ExplicitTop = 2
      ExplicitWidth = 820
      ExplicitHeight = 44
      inherited btnIncluir: TBitBtnLocked
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 84
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 84
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 168
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 168
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 252
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 252
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 336
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 336
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 420
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 420
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      object btnImprimir: TBitBtnLocked
        Left = 504
        Top = 0
        Width = 84
        Height = 21
        Caption = '[F6] Imprimir'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000C000000120000001400000014000000150000
          0015000000140000000D00000003000000000000000000000000000000000000
          00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
          78FFBE8978FF876356C30000000B000000000000000000000000000000030000
          000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
          E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
          42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
          72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
          6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
          76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
          71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
          35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
          78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
          DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
          7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
          32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
          86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
          42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
          8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
          DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
          84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
          E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
          2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
          E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
          0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
          E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
          00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
          EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
          00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
          FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
          000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
          91FFCDA391FF98786BC100000004000000000000000000000000}
        Spacing = 2
        TabOrder = 6
        OnClick = btnImprimirClick
      end
      object btnCancelarContrato: TBitBtnLocked
        Left = 588
        Top = 0
        Width = 125
        Height = 21
        Caption = '[F7] Cancelar Contrato'
        Spacing = 2
        TabOrder = 7
        OnClick = btnCancelarContratoClick
      end
      object btnExpandirTodos: TBitBtnLocked
        Left = 0
        Top = 21
        Width = 128
        Height = 21
        Caption = '[F11] [+] Expandir Todos'
        TabOrder = 8
        OnClick = btnExpandirTodosClick
      end
      object btnRetrairTodos: TBitBtnLocked
        Left = 128
        Top = 21
        Width = 128
        Height = 21
        Caption = '[F12] [-] Retrair Todos'
        TabOrder = 9
        OnClick = btnRetrairTodosClick
      end
      object btnEncerrarContrato: TBitBtnLocked
        Left = 256
        Top = 21
        Width = 125
        Height = 21
        Caption = 'Encerrar Contrato'
        Spacing = 2
        TabOrder = 10
        OnClick = btnEncerrarContratoClick
      end
      object btnGerarPedidoAdt: TBitBtnLocked
        Left = 381
        Top = 21
        Width = 176
        Height = 21
        Caption = 'Gerar Pedido Adiantamento'
        TabOrder = 11
        OnClick = btnGerarPedidoAdtClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 721
      Width = 100
      Height = 21
      Anchors = [akTop, akRight]
      ExplicitLeft = 721
      ExplicitWidth = 100
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 689
    Width = 824
    TabOrder = 6
    ExplicitTop = 689
    ExplicitWidth = 824
    inherited pnlNomeForm: TPanel
      Left = 477
      ExplicitLeft = 477
    end
    inherited pnlInfo: TPanel
      Width = 477
      ExplicitWidth = 477
      object btnShowTrace: TSpeedButton
        Left = 475
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 475
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  inherited pgcDados: TPageControl
    Left = 649
    Top = 457
    Width = 137
    Height = 65
    Align = alNone
    TabOrder = 7
    Visible = False
    ExplicitLeft = 649
    ExplicitTop = 457
    ExplicitWidth = 137
    ExplicitHeight = 65
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 129
      ExplicitHeight = 33
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 824
    Height = 34
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lblNumCon: TLabel
      Left = 12
      Top = 8
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblStatus: TLabel
      Left = 228
      Top = 8
      Width = 45
      Height = 14
      Caption = 'Situa'#231#227'o:'
    end
    object edtNumCon: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 5
      Width = 95
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQL_NROCON'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cmbStatus: TComboBoxFocus
      Tag = 99
      Left = 279
      Top = 4
      Width = 93
      Height = 22
      Style = csDropDownList
      Enabled = False
      TabOrder = 1
      OnClick = cmbStatusClick
      Items.Strings = (
        'OR'#199'AMENTO'
        'ATIVO')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  object pnlTotal: TPanel [4]
    Left = 0
    Top = 584
    Width = 824
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      824
      57)
    object lblQtde: TLabel
      Left = 461
      Top = 33
      Width = 61
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Qtde. Equip.:'
    end
    object lblTotCon: TLabel
      Left = 659
      Top = 33
      Width = 53
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Valor Total:'
    end
    object lblAut_PD: TLabel
      Left = 8
      Top = 7
      Width = 164
      Height = 14
      Caption = 'Pedido gerado para adiantamento:'
    end
    object Label6: TLabel
      Left = 456
      Top = 7
      Width = 66
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Taxa Entrega:'
    end
    object lblVlrAdcAcessorio: TLabel
      Left = 618
      Top = 7
      Width = 94
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Vlr.Adc. Acess'#243'rio:'
    end
    object edtTotCon: TDBEditFocus
      Tag = 99
      Left = 718
      Top = 29
      Width = 95
      Height = 22
      TabStop = False
      Anchors = [akTop, akRight]
      Color = 16768952
      DataField = 'EQL_TOTCON'
      DataSource = dtsTabela
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtQtde: TDBEditFocus
      Tag = 99
      Left = 528
      Top = 29
      Width = 68
      Height = 22
      TabStop = False
      Anchors = [akTop, akRight]
      Color = 16768952
      DataField = 'EQL_QTDEQU'
      DataSource = dtsTabela
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtAutIncFatGor: TEditFocus
      Tag = 99
      Left = 176
      Top = 3
      Width = 172
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtTaxEnt: TDBEditFocus
      Left = 528
      Top = 3
      Width = 68
      Height = 22
      Anchors = [akTop, akRight]
      DataField = 'EQL_TAXENT'
      DataSource = dtsTabela
      TabOrder = 0
      OnExit = edtTaxEntExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtVlrAdc: TDBEditFocus
      Tag = 99
      Left = 718
      Top = 3
      Width = 95
      Height = 22
      TabStop = False
      Anchors = [akTop, akRight]
      Color = 16768952
      DataField = 'EQL_TOTADC'
      DataSource = dtsTabela
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object pnlCondicaoPgto: TPanel [5]
    Left = 0
    Top = 229
    Width = 824
    Height = 78
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object pnlCondicaoPagamento: TcxGroupBox
      AlignWithMargins = True
      Left = 0
      Top = 0
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Caption = '  Pagamento'
      Style.BorderStyle = ebs3D
      StyleDisabled.BorderStyle = ebs3D
      TabOrder = 0
      Height = 76
      Width = 824
      inline fraPagamento: TfraDigCndPagamento
        Left = 2
        Top = 19
        Width = 820
        Height = 55
        VertScrollBar.Range = 45
        Align = alClient
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 19
        ExplicitWidth = 820
        ExplicitHeight = 55
        inherited pnlFundo: TPanel
          Width = 820
          Height = 55
          BevelInner = bvNone
          BevelOuter = bvNone
          ExplicitWidth = 820
          ExplicitHeight = 55
          inherited pnlCndPag: TPanel
            Left = 0
            Top = 24
            Width = 820
            ExplicitLeft = 0
            ExplicitTop = 24
            ExplicitWidth = 820
            inherited lblCndPag: TLabel
              Left = 29
              ExplicitLeft = 29
            end
            inherited lblObs: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtCodCnd: TEditFocus
              Left = 103
              Width = 64
              ExplicitLeft = 103
              ExplicitWidth = 64
            end
            inherited mskCndPag: TMaskEditFocus
              Left = 169
              Width = 638
              Anchors = [akLeft, akTop, akRight]
              ExplicitLeft = 169
              ExplicitWidth = 638
            end
            inherited pnlTrocarCondPagamento: TPanel
              inherited lblTrocarCondPagamento: TLabel
                Font.Pitch = fpVariable
              end
            end
          end
          inherited pnlForPag: TPanel
            Left = 0
            Top = 59
            Width = 820
            ExplicitLeft = 0
            ExplicitTop = 59
            ExplicitWidth = 820
            inherited Label2: TLabel
              Left = 17
              Top = 4
              ExplicitLeft = 17
              ExplicitTop = 4
            end
            inherited edtForPag: TEditFocus
              Left = 103
              Top = 0
              Width = 64
              ExplicitLeft = 103
              ExplicitTop = 0
              ExplicitWidth = 64
            end
            inherited edtDesForPag: TEditFocus
              Left = 169
              Width = 638
              Anchors = [akLeft, akTop, akRight]
              ExplicitLeft = 169
              ExplicitWidth = 638
            end
          end
          inherited pnlDados: TPanel
            Left = 0
            Top = 106
            Width = 820
            ExplicitLeft = 0
            ExplicitTop = 106
            ExplicitWidth = 820
            inherited dbgDupAgru: TDBGridCitel
              TitleFont.Pitch = fpVariable
            end
          end
          inherited pnlChecks: TPanel
            Left = 0
            Top = 83
            Width = 820
            Height = 23
            ExplicitLeft = 0
            ExplicitTop = 83
            ExplicitWidth = 820
            ExplicitHeight = 23
            inherited lblPagamentoPix: TLabel
              Font.Pitch = fpVariable
            end
          end
          inherited pnlPrevisao: TPanel
            Left = 0
            Top = 0
            Width = 820
            Visible = False
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 820
            inherited lblPreVis: TLabel
              Left = 52
              ExplicitLeft = 52
            end
            inherited mskPreVis: TMaskEditFocus
              Left = 103
              Top = 3
              Width = 64
              ExplicitLeft = 103
              ExplicitTop = 3
              ExplicitWidth = 64
            end
          end
        end
      end
    end
  end
  object pnlEquipamentos: TPanel [6]
    Left = 0
    Top = 307
    Width = 824
    Height = 277
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object PCEquipamentos: TPageControl
      Left = 0
      Top = 0
      Width = 824
      Height = 277
      ActivePage = tsEquipamentos
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      TabStop = False
      object tsEquipamentos: TTabSheet
        Caption = 'Equipamentos do Contrato'
        object grpDetalhes: TGroupBox
          Left = 0
          Top = 0
          Width = 816
          Height = 245
          Align = alClient
          TabOrder = 0
          object pnlAdicionarItens: TPanel
            Left = 2
            Top = 16
            Width = 812
            Height = 115
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            DesignSize = (
              812
              115)
            object lblCodEql: TLabel
              Left = 33
              Top = 3
              Width = 64
              Height = 14
              Caption = 'Equipamento:'
            end
            object Label4: TLabel
              Left = 189
              Top = 36
              Width = 73
              Height = 14
              Caption = 'Contratado em:'
            end
            object lblValorLocacao: TLabel
              Left = 13
              Top = 65
              Width = 84
              Height = 14
              Caption = 'Valor Hora/Di'#225'ria:'
            end
            object Label7: TLabel
              Left = 335
              Top = 65
              Width = 70
              Height = 14
              Caption = 'Desconto (%):'
            end
            object Label8: TLabel
              Left = 478
              Top = 65
              Width = 104
              Height = 14
              Caption = 'Valor Hora/Di'#225'ria L'#237'q.:'
            end
            object Label9: TLabel
              Left = 670
              Top = 65
              Width = 73
              Height = 14
              Caption = 'Valor Total L'#237'q.:'
            end
            object Label1: TLabel
              Left = 188
              Top = 64
              Width = 53
              Height = 14
              Caption = 'Valor Total:'
            end
            object lblQtdEqu: TLabel
              Left = 39
              Top = 36
              Width = 58
              Height = 14
              Caption = 'Quantidade:'
            end
            object edtCodEql: TEditFocus
              Tag = 99
              Left = 103
              Top = 0
              Width = 64
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtCodEqlKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object btnAdicionar: TBitBtnLocked
              Left = 603
              Top = 87
              Width = 95
              Height = 24
              Anchors = [akTop, akRight]
              Caption = 'Adicionar'
              Enabled = False
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                00000000000000000002000000070000000C0000001000000012000000110000
                000E000000080000000200000000000000000000000000000000000000000000
                000100000004000101120F291D791A4B36C624674AFF24674AFF24684AFF1C50
                3AD2112D21840001011500000005000000010000000000000000000000000000
                0005050E0A351E573FDC287B5AFF2FA57BFF33BD8FFF34C090FF34BE90FF30A7
                7DFF29805EFF1C533CD406100B3D00000007000000010000000000000003050D
                0A31226247ED2E9772FF36C093FF35C193FF5CCEA9FF6DD4B2FF42C69AFF37C1
                93FF39C296FF319E77FF266C4FF806100C3D00000005000000000000000A1D54
                3CD0349F7AFF3AC295FF35C092FF52CBA5FF257E5BFF05623AFF4BB894FF38C3
                95FF38C395FF3BC498FF37A781FF1F5941D300010113000000020C22185E3285
                64FF42C69BFF37C294FF51CCA6FF38906FFF89AD9DFFB2CDC0FF28855FFF4CCC
                A5FF3DC79BFF3AC597FF45C9A0FF368F6EFF1030237F000000071A4A36B643AD
                8AFF40C69CFF51CEA6FF479E80FF6B9582FFF7F1EEFFF8F3EEFF387B5CFF5BBE
                9EFF4ACEA5FF45CBA1FF43C9A0FF47B692FF1E5942CD0000000B1F6045DF51C4
                A1FF4BCBA5FF54AE90FF507F69FFEFE9E6FFBFC2B5FFEEE3DEFFCEDCD4FF1F70
                4EFF66D6B5FF4FD1A9FF4ECFA7FF57CDA9FF287557F80000000E256C4FF26BD3
                B5FF4DCCA5FF0F6240FFD1D1CBFF6C8D78FF156642FF74947EFFF0E8E3FF749F
                8AFF4AA183FF64D8B6FF53D2ACFF71DCBFFF2B7F5EFF02060419226549DC7CD4
                BBFF58D3AEFF43B48FFF0D6440FF349674FF5DD7B4FF329371FF74947EFFEFEA
                E7FF52856CFF5EB698FF61D7B5FF84DDC4FF2B7E5DF80000000C1B4F3AAB7BC4
                AEFF68DAB9FF5CD6B3FF5FD8B6FF62DAB9FF64DBBAFF65DDBDFF2D8766FF6B8C
                77FFE5E0DCFF1B6746FF65D2B1FF87D1BBFF21634BC6000000090B1F17474797
                79FF99E8D4FF60D8B6FF64DBBAFF67DDBBFF6ADFBDFF6DE0C2FF6DE1C3FF3E9C
                7CFF23694AFF2D8663FF9CEBD7FF51A78AFF1234276D00000004000000041F5C
                45B57CC2ABFF9EEAD7FF6BDEBCFF6AE0BFFF6FE1C3FF71E2C5FF72E3C6FF71E4
                C6FF64D0B3FF9BE9D5FF8ACFB9FF287358D20102010C00000001000000010309
                0718287759DA74BDA6FFB8EFE1FF9CEBD7FF8AE8D1FF7BE5CAFF8DEAD3FFA0EE
                DBFFBDF1E5FF7CC9B1FF2F8B6BEA0715102E0000000200000000000000000000
                0001030A071721664DB849A685FF89CEB9FFABE3D4FFC7F1E9FFAEE6D6FF8DD4
                BFFF50B190FF277B5DCB06120E27000000030000000000000000000000000000
                000000000001000000030B231B411E5C469D297F62CF319775EE2A8365CF236D
                54B0103125560000000600000002000000000000000000000000}
              TabOrder = 9
              OnClick = btnAdicionarClick
            end
            object rgTipoDuracaoLocacao: TRadioGroup
              Left = 265
              Top = 25
              Width = 265
              Height = 33
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Columns = 3
              Items.Strings = (
                'Dias'
                'Horas'
                'Meses')
              TabOrder = 3
              OnClick = rgTipoDuracaoLocacaoClick
              OnExit = rgTipoDuracaoLocacaoExit
            end
            object edtVlrLoc: TCurrencyEditFocus
              Tag = 99
              Left = 103
              Top = 61
              Enabled = False
              StyleFocused.Color = clInfoBk
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              Width = 64
            end
            object edtVlrTot: TCurrencyEditFocus
              Tag = 99
              Left = 246
              Top = 61
              Enabled = False
              StyleFocused.Color = clInfoBk
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              Width = 70
            end
            object edtDesEql: TEditFocus
              Tag = 99
              Left = 169
              Top = 0
              Width = 638
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
              CharCase = ecUpperCase
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 67
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
            object edtVlrDsc: TEditFocus
              Tag = 99
              Left = 411
              Top = 61
              Width = 58
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
              ParentFont = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtVlrLocLiq: TEditFocus
              Tag = 99
              Left = 588
              Top = 60
              Width = 58
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
              ParentFont = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.0000'
            end
            object edtVlrTotLiq: TEditFocus
              Tag = 99
              Left = 749
              Top = 61
              Width = 58
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
              ParentFont = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object btnCancelaItem: TBitBtnLocked
              Left = 704
              Top = 87
              Width = 95
              Height = 24
              Anchors = [akTop, akRight]
              Caption = 'C&ancelar'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
                015603015603FF00FF0000820000820000820000820000820000820000820000
                820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
                27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
                30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
                FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
                0082000082000082000082000082000082000082000082000082FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
                00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
                0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
                50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
                5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
                8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 10
              OnClick = btnCancelaItemClick
            end
            object edtQtdEqu: TEditFocus
              Tag = 99
              Left = 103
              Top = 33
              Width = 64
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
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0'
            end
          end
          object cxGrdItens: TcxGridCitel
            Left = 2
            Top = 131
            Width = 812
            Height = 96
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGrdItensView: TcxGridDBTableViewCitel
              OnKeyUp = cxGrdItensViewKeyUp
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsEqlDet
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.PullFocusing = True
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.HideFocusRectOnExit = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object grdItensEQL_CODIGO: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'EQD_SEQEQL'
                Width = 78
              end
              object grdItensEQL_DESCRI: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'EQD_DESCRI'
                Width = 277
              end
              object grdItensEQL_NSERIE: TcxGridDBColumn
                Caption = 'N'#250'mero de S'#233'rie'
                DataBinding.FieldName = 'EQD_NSERIE'
                Width = 95
              end
              object grdItensTIPO_CONTRATO: TcxGridDBColumn
                Caption = 'Contratado em'
                DataBinding.FieldName = 'TIPO_CONTRATO'
                Width = 77
              end
              object grdItensEQD_QTDEQU: TcxGridDBColumn
                Caption = 'Quantidade'
                DataBinding.FieldName = 'EQD_QTDEQU'
              end
              object grdItensEQL_VALLOC: TcxGridDBColumn
                Caption = 'Valor Hora / Di'#225'ria'
                DataBinding.FieldName = 'EQD_VALHOR'
                Width = 99
              end
              object grdItensEQL_TOTLOC: TcxGridDBColumn
                Caption = 'Valor Total'
                DataBinding.FieldName = 'EQD_TOTEQL'
                Width = 98
              end
              object grdItensEQD_PERDES: TcxGridDBColumn
                Caption = 'Desconto (%)'
                DataBinding.FieldName = 'EQD_PERDES'
                Width = 73
              end
              object grdItensEQD_VLLOCL: TcxGridDBColumn
                Caption = 'Valor Hora/Di'#225'ria L'#237'q.'
                DataBinding.FieldName = 'EQD_VLLOCL'
                Width = 113
              end
              object grdItensEQD_TOTLIQ: TcxGridDBColumn
                Caption = 'Valor Total L'#237'q.'
                DataBinding.FieldName = 'EQD_TOTLIQ'
                Width = 120
              end
              object grdItensEQL_SITENC: TcxGridDBColumn
                Caption = 'Situa'#231#227'o do Equipamento'
                DataBinding.FieldName = 'EQL_SITENC'
                Width = 127
              end
            end
            object cxGrdAcessoriosTableView: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsEqlAcl
              DataController.DetailKeyFieldNames = 'EQA_SEQEQU'
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.KeyFieldNames = 'EQA_SEQEQU'
              DataController.MasterKeyFieldNames = 'EQD_SEQEQL'
              DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
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
              OptionsSelection.CellSelect = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxGrdAcessoriosTableViewCODIGO: TcxGridDBColumn
                Caption = 'C'#243'd. Acess'#243'rio'
                DataBinding.FieldName = 'CODIGO'
              end
              object cxGrdAcessoriosTableViewDESCRICAO: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESCRICAO'
              end
              object cxGrdAcessoriosTableViewQUANTIDADE: TcxGridDBColumn
                Caption = 'Quantidade'
                DataBinding.FieldName = 'QUANTIDADE'
              end
              object cxGrdAcessoriosTableViewEQA_QTDTOT: TcxGridDBColumn
                Caption = 'Qtde.Total'
                DataBinding.FieldName = 'EQA_QTDTOT'
              end
              object cxGrdAcessoriosTableViewColumn1: TcxGridDBColumn
                Caption = 'Vlr.Adicional'
                DataBinding.FieldName = 'EQA_VLRADC'
              end
              object cxGrdAcessoriosTableViewEQA_TOTADC: TcxGridDBColumn
                Caption = 'Vlr. Adicional Total'
                DataBinding.FieldName = 'EQA_TOTADC'
                Options.Editing = False
              end
            end
            object cxGrdItensLvl: TcxGridLevel
              GridView = cxGrdItensView
              object cxGrdAcessorios: TcxGridLevel
                GridView = cxGrdAcessoriosTableView
              end
            end
          end
          object pnlRodape: TPanel
            Left = 2
            Top = 227
            Width = 812
            Height = 16
            Align = alBottom
            Alignment = taLeftJustify
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object lblInfo: TLabel
              Left = 0
              Top = 0
              Width = 812
              Height = 16
              Align = alClient
              ExplicitWidth = 3
              ExplicitHeight = 14
            end
          end
        end
      end
      object tsNegociacao: TTabSheet
        Caption = 'Negocia'#231#227'o de Di'#225'rias'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object cxGridNegociacaoDiarias: TcxGridCitel
          Tag = 99
          Left = 0
          Top = 0
          Width = 816
          Height = 225
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsNegociacaoDiarias
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
            object cxGridDBTableViewCitel1QTDDIA: TcxGridDBColumn
              Caption = 'Quantidade de Dias'
              DataBinding.FieldName = 'QTDDIA'
              Width = 150
            end
            object cxGridDBTableViewCitel1VLRTOT: TcxGridDBColumn
              Caption = 'Valor Total'
              DataBinding.FieldName = 'VLRTOT'
              Width = 178
            end
            object cxGridDBTableViewCitel1VLRDIA: TcxGridDBColumn
              Caption = 'Valor Calculado da Di'#225'ria'
              DataBinding.FieldName = 'VLRDIA'
              Width = 153
            end
            object cxGridDBTableViewCitel1DTAEST: TcxGridDBColumn
              Caption = 'T'#233'rmino Em'
              DataBinding.FieldName = 'DTAEST'
              Width = 177
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableViewCitel1
          end
        end
        object pnlRodapeNegociacao: TPanel
          Left = 0
          Top = 225
          Width = 816
          Height = 20
          Align = alBottom
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = '  Pressione DELETE para excluir algum registro do grid'
          ParentColor = True
          TabOrder = 1
        end
      end
    end
  end
  object pnlBotoesSQLTrace: TPanel [7]
    Left = 0
    Top = 524
    Width = 824
    Height = 0
    TabOrder = 8
    Visible = False
    object lblNSQLTrace: TLabel
      Left = 761
      Top = 0
      Width = 3
      Height = 14
    end
  end
  object PCDadosContrato: TPageControl [8]
    Left = 0
    Top = 34
    Width = 824
    Height = 195
    ActivePage = tsDadosGerais
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 1
    TabStop = False
    object tsDadosGerais: TTabSheet
      Caption = 'Geral'
      ImageIndex = 1
      object pnlDadosContrato: TPanel
        Left = 0
        Top = 0
        Width = 816
        Height = 88
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object splResp: TSplitter
          Left = 421
          Top = 0
          Height = 88
          Align = alRight
          ExplicitLeft = 488
          ExplicitTop = 48
          ExplicitHeight = 100
        end
        object pnlDadosCliente: TPanel
          Left = 0
          Top = 0
          Width = 421
          Height = 88
          Align = alClient
          TabOrder = 0
          DesignSize = (
            421
            88)
          object lblEntCli: TLabel
            Left = 11
            Top = 61
            Width = 61
            Height = 14
            Caption = 'Localiza'#231#227'o:'
          end
          object lblCodVen: TLabel
            Left = 22
            Top = 37
            Width = 50
            Height = 14
            Caption = 'Vendedor:'
          end
          object lblCodCli: TLabel
            Left = 37
            Top = 13
            Width = 35
            Height = 14
            Caption = 'Cliente:'
          end
          object cmbEntCli: TDBLookupComboBoxFocus
            Tag = 99
            Left = 78
            Top = 58
            Width = 335
            Height = 22
            Anchors = [akLeft, akTop, akRight]
            DataField = 'EQL_ENTCLI'
            DataSource = dtsTabela
            KeyField = 'AUTOINCREM'
            ListField = 'ETC_ENDENT'
            ListSource = dtsEndereco
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtCodVen: TDBEditFocus
            Tag = 99
            Left = 78
            Top = 33
            Width = 64
            Height = 22
            CharCase = ecUpperCase
            DataField = 'EQL_CODVEN'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            OnKeyPress = edtCodVenKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtNomVen: TEditFocus
            Tag = 99
            Left = 146
            Top = 34
            Width = 269
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Anchors = [akLeft, akTop, akRight]
            CharCase = ecUpperCase
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 67
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
          object edtNomCli: TEditFocus
            Tag = 99
            Left = 146
            Top = 9
            Width = 269
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Anchors = [akLeft, akTop, akRight]
            CharCase = ecUpperCase
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 67
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
          object edtCodCli: TDBEditFocus
            Tag = 99
            Left = 78
            Top = 9
            Width = 64
            Height = 22
            CharCase = ecUpperCase
            DataField = 'EQL_CODCLI'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = edtCodCliKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
        end
        object pnlResponsaveis: TPanel
          Left = 424
          Top = 0
          Width = 392
          Height = 88
          Align = alRight
          TabOrder = 1
          object cxGridResponsaveis: TcxGridCitel
            Left = 1
            Top = 1
            Width = 390
            Height = 86
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGridTableResponsavel: TcxGridDBTableViewCitel
              OnKeyPress = cxGridTableResponsavelKeyPress
              Navigator.Buttons.CustomButtons = <>
              Navigator.Buttons.First.Visible = True
              Navigator.Buttons.PriorPage.Visible = True
              Navigator.Buttons.Prior.Visible = True
              Navigator.Buttons.Next.Visible = True
              Navigator.Buttons.NextPage.Visible = True
              Navigator.Buttons.Last.Visible = True
              Navigator.Buttons.Insert.Visible = True
              Navigator.Buttons.Append.Visible = False
              Navigator.Buttons.Delete.Visible = True
              Navigator.Buttons.Edit.Visible = True
              Navigator.Buttons.Post.Visible = True
              Navigator.Buttons.Cancel.Visible = True
              Navigator.Buttons.Refresh.Visible = True
              Navigator.Buttons.SaveBookmark.Visible = True
              Navigator.Buttons.GotoBookmark.Visible = True
              Navigator.Buttons.Filter.Visible = True
              DataController.DataSource = dtsCliCtt
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsData.CancelOnExit = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxGridTableResponsavelMARCADO: TcxGridDBColumn
                Caption = 'Sel.'
                DataBinding.FieldName = 'MARCADO'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                Properties.OnChange = cxGridTableResponsavelMARCADOPropertiesChange
                Width = 32
              end
              object cxGridTableResponsavelNOMCGO: TcxGridDBColumn
                Caption = 'Cargo'
                DataBinding.FieldName = 'CLI_NOMCGO'
                Options.Editing = False
                Width = 80
              end
              object cxGridTableResponsavelNOMCTT: TcxGridDBColumn
                Caption = 'Nome'
                DataBinding.FieldName = 'CLI_NOMCTT'
                Options.Editing = False
                Width = 115
              end
              object cxGridTableResponsavelCPFCTT: TcxGridDBColumn
                Caption = 'CPF'
                DataBinding.FieldName = 'CLI_CPFCTT'
                Options.Editing = False
                Width = 84
              end
              object cxGridTableResponsavelRG_CTT: TcxGridDBColumn
                Caption = 'RG'
                DataBinding.FieldName = 'CLI_RG_CTT'
                Options.Editing = False
                Width = 78
              end
            end
            object cxGridResponsaveisLevel1: TcxGridLevel
              GridView = cxGridTableResponsavel
            end
          end
        end
      end
      object pnlDuracao: TPanel
        Left = 0
        Top = 88
        Width = 816
        Height = 68
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object grbDuracao: TGroupBox
          Left = 0
          Top = 0
          Width = 816
          Height = 68
          Align = alClient
          Caption = '  Dura'#231#227'o do Contrato   '
          TabOrder = 0
          object pnlDuracaoDiariaHora: TPanel
            Left = 2
            Top = 16
            Width = 812
            Height = 23
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object lblInicio: TLabel
              Left = 72
              Top = 7
              Width = 27
              Height = 14
              Caption = 'In'#237'cio:'
            end
            object lblTermino: TLabel
              Left = 231
              Top = 2
              Width = 41
              Height = 14
              Caption = 'T'#233'rmino:'
            end
            object Label3: TLabel
              Left = 475
              Top = 4
              Width = 64
              Height = 14
              Caption = 'Total de Dias:'
            end
            object Label2: TLabel
              Left = 622
              Top = 4
              Width = 72
              Height = 14
              Caption = 'Total de Horas:'
            end
            object edtDtaIni: TDBEditFocus
              Tag = 99
              Left = 103
              Top = 1
              Width = 64
              Height = 22
              CharCase = ecUpperCase
              DataField = 'EQL_DTAINI'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtHorIni: TDBEditFocus
              Tag = 99
              Left = 170
              Top = 1
              Width = 40
              Height = 22
              DataField = 'EQL_HORINI'
              DataSource = dtsTabela
              MaxLength = 5
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtDtaFin: TDBEditFocus
              Tag = 99
              Left = 276
              Top = 1
              Width = 64
              Height = 22
              CharCase = ecUpperCase
              DataField = 'EQL_DTAFIN'
              DataSource = dtsTabela
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtHorFin: TDBEditFocus
              Tag = 99
              Left = 343
              Top = 1
              Width = 40
              Height = 22
              DataField = 'EQL_HORFIN'
              DataSource = dtsTabela
              MaxLength = 5
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtTotDia: TDBEditFocus
              Tag = 99
              Left = 543
              Top = 0
              Width = 64
              Height = 22
              TabStop = False
              Color = 16768952
              DataField = 'EQL_TOTDIA'
              DataSource = dtsTabela
              Enabled = False
              MaxLength = 7
              ReadOnly = True
              TabOrder = 4
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtTotHor: TDBEditFocus
              Tag = 99
              Left = 698
              Top = 0
              Width = 64
              Height = 22
              TabStop = False
              Color = 16768952
              DataField = 'EQL_TOTHOR'
              DataSource = dtsTabela
              Enabled = False
              MaxLength = 7
              ReadOnly = True
              TabOrder = 5
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlDuracaoMensal: TPanel
            Left = 2
            Top = 39
            Width = 812
            Height = 27
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object lblMesIni: TLabel
              Left = 47
              Top = 6
              Width = 52
              Height = 14
              Caption = 'M'#234's Inicial:'
            end
            object lblMesFin: TLabel
              Left = 224
              Top = 6
              Width = 48
              Height = 14
              Caption = 'M'#234's Final:'
            end
            object lblTotMes: TLabel
              Left = 464
              Top = 6
              Width = 75
              Height = 14
              Caption = 'Total de Meses:'
            end
            object edtMesIni: TMaskEditFocus
              Tag = 99
              Left = 103
              Top = 3
              Width = 58
              Height = 22
              EditMask = '99/9999'
              MaxLength = 7
              TabOrder = 0
              Text = '  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object edtMesFin: TMaskEditFocus
              Tag = 99
              Left = 276
              Top = 3
              Width = 59
              Height = 22
              EditMask = '99/9999'
              MaxLength = 7
              TabOrder = 1
              Text = '  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object edtTotMes: TDBEditFocus
              Tag = 99
              Left = 543
              Top = 3
              Width = 64
              Height = 22
              TabStop = False
              Color = 16768952
              DataField = 'EQL_TOTMES'
              DataSource = dtsTabela
              Enabled = False
              MaxLength = 7
              ReadOnly = True
              TabOrder = 2
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
    end
    object tsInfAdicionais: TTabSheet
      Caption = 'Informa'#231#245'es Adicionais'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        816
        163)
      object Label10: TLabel
        Left = 17
        Top = 6
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#176' Pedido Compra:'
      end
      object Label11: TLabel
        Left = 55
        Top = 30
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'End. Obra:'
      end
      object edtEndObr: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 27
        Width = 508
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        DataField = 'EQL_ENDOBR'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 60
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtNumCmp: TDBEditFocus
        Tag = 99
        Left = 112
        Top = 4
        Width = 122
        Height = 22
        CharCase = ecUpperCase
        DataField = 'EQL_PEDCOM'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 1
        OnKeyPress = edtNumCmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 194
  end
  object dtsTabela: TDataSource
    Left = 688
    Top = 18
  end
  object dtsEndereco: TDataSource
    Left = 696
    Top = 66
  end
  object dtsEqlDet: TDataSource
    DataSet = cdsEqlDet
    Left = 444
    Top = 175
  end
  object dtsEqlAcl: TDataSource
    DataSet = csdEqlAce
    Left = 384
    Top = 171
  end
  object csdEqlAce: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 175
    object csdEqlAceCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object csdEqlAceDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 70
    end
    object csdEqlAceQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object csdEqlAceEQA_SEQEQU: TStringField
      FieldName = 'EQA_SEQEQU'
    end
    object csdEqlAceEQA_SEQACL: TStringField
      FieldName = 'EQA_SEQACL'
    end
    object csdEqlAceEQA_VLRAQU: TFloatField
      FieldName = 'EQA_VLRAQU'
    end
    object csdEqlAceEQA_TOTAQU: TFloatField
      FieldName = 'EQA_TOTAQU'
    end
    object csdEqlAceEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
    object csdEqlAceEQA_VLRADC: TFloatField
      FieldName = 'EQA_VLRADC'
    end
    object csdEqlAceEQA_TOTADC: TFloatField
      FieldName = 'EQA_TOTADC'
    end
  end
  object cdsEqlDet: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_DSCVEN'
        DataType = ftFloat
      end
      item
        Name = 'EQL_DSCSGE'
        DataType = ftFloat
      end
      item
        Name = 'EQL_DSCGER'
        DataType = ftFloat
      end
      item
        Name = 'EQL_VALLOC'
        DataType = ftFloat
      end
      item
        Name = 'EQD_VLLOCL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTLIQ'
        DataType = ftFloat
      end
      item
        Name = 'EQD_PERDES'
        DataType = ftFloat
      end
      item
        Name = 'EQL_VLRCAU'
        DataType = ftFloat
      end
      item
        Name = 'EQD_VLRALT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_VALHOR'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTEQL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_TIPDUR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_CODIGO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_NSERIE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPO_CONTRATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_SITENC'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'EQD_DTAENC'
        DataType = ftDateTime
      end
      item
        Name = 'EQL_VLRAQU'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTDIA'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTHOR'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTMES'
        DataType = ftFloat
      end
      item
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 336
    Top = 171
    object cdsEqlDetEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object cdsEqlDetEQL_DSCVEN: TFloatField
      FieldName = 'EQL_DSCVEN'
    end
    object cdsEqlDetEQL_DSCSGE: TFloatField
      FieldName = 'EQL_DSCSGE'
    end
    object cdsEqlDetEQL_DSCGER: TFloatField
      FieldName = 'EQL_DSCGER'
    end
    object cdsEqlDetEQL_VALLOC: TFloatField
      FieldName = 'EQL_VALLOC'
    end
    object cdsEqlDetEQD_VLLOCL: TFloatField
      FieldName = 'EQD_VLLOCL'
    end
    object cdsEqlDetEQD_TOTLIQ: TFloatField
      FieldName = 'EQD_TOTLIQ'
    end
    object cdsEqlDetEQD_PERDES: TFloatField
      FieldName = 'EQD_PERDES'
    end
    object cdsEqlDetEQL_VLRCAU: TFloatField
      FieldName = 'EQL_VLRCAU'
    end
    object cdsEqlDetTIPO_CONTRATO: TStringField
      FieldName = 'TIPO_CONTRATO'
    end
    object cdsEqlDetEQD_VLRALT: TStringField
      FieldName = 'EQD_VLRALT'
    end
    object cdsEqlDetEQD_VALHOR: TFloatField
      FieldName = 'EQD_VALHOR'
    end
    object cdsEqlDetEQD_TOTEQL: TFloatField
      FieldName = 'EQD_TOTEQL'
    end
    object cdsEqlDetEQD_DESCRI: TStringField
      FieldName = 'EQD_DESCRI'
      Size = 100
    end
    object cdsEqlDetEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsEqlDetEQD_TIPDUR: TStringField
      FieldName = 'EQD_TIPDUR'
    end
    object cdsEqlDetEQL_CODIGO: TStringField
      FieldName = 'EQL_CODIGO'
    end
    object cdsEqlDetEQD_NSERIE: TStringField
      FieldName = 'EQD_NSERIE'
    end
    object cdsEqlDetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEqlDetEQL_SITENC: TStringField
      DisplayWidth = 35
      FieldName = 'EQL_SITENC'
      Size = 35
    end
    object cdsEqlDetEQD_DTAENC: TDateTimeField
      FieldName = 'EQD_DTAENC'
    end
    object cdsEqlDetEQL_VLRAQU: TFloatField
      FieldName = 'EQL_VLRAQU'
    end
    object cdsEqlDetEQD_TOTDIA: TFloatField
      FieldName = 'EQD_TOTDIA'
    end
    object cdsEqlDetEQD_TOTHOR: TFloatField
      FieldName = 'EQD_TOTHOR'
    end
    object cdsEqlDetEQD_TOTMES: TFloatField
      FieldName = 'EQD_TOTMES'
    end
    object cdsEqlDetEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object dtsNegociacaoDiarias: TUniDataSource
    DataSet = cdsNegociacaoDiarias
    Left = 580
    Top = 177
  end
  object cdsNegociacaoDiarias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'QTDDIA'
        DataType = ftInteger
      end
      item
        Name = 'VLRTOT'
        DataType = ftFloat
      end
      item
        Name = 'VLRDIA'
        DataType = ftFloat
      end
      item
        Name = 'INDEX'
        DataType = ftInteger
      end
      item
        Name = 'DTAEST'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 388
    Top = 233
    object cdsNegociacaoDiariasQTDDIA: TIntegerField
      FieldName = 'QTDDIA'
    end
    object cdsNegociacaoDiariasVLRTOT: TFloatField
      FieldName = 'VLRTOT'
      DisplayFormat = '#,##0.00'
    end
    object cdsNegociacaoDiariasVLRDIA: TFloatField
      FieldName = 'VLRDIA'
      DisplayFormat = '#,##0.00'
    end
    object cdsNegociacaoDiariasDTAEST: TDateTimeField
      FieldName = 'DTAEST'
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 332
    Top = 447
  end
  object cdsCliCtt: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 525
    Top = 23
    object cdsCliCttAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCliCttCPFCTT: TStringField
      FieldName = 'CLI_CPFCTT'
      Size = 11
    end
    object cdsCliCttRG_CTT: TStringField
      FieldName = 'CLI_RG_CTT'
      Size = 15
    end
    object cdsCliCttNOMCTT: TStringField
      FieldName = 'CLI_NOMCTT'
      Size = 50
    end
    object cdsCliCttCGOCTT: TStringField
      FieldName = 'CLI_CGOCTT'
      Size = 5
    end
    object cdsCliCttNOMCGO: TStringField
      FieldName = 'CLI_NOMCGO'
      Size = 50
    end
    object cdsCliCttMARCADO: TStringField
      FieldName = 'MARCADO'
    end
    object cdsCliCttCLI_CODCLI: TStringField
      FieldName = 'CLI_CODCLI'
    end
  end
  object dtsCliCtt: TDataSource
    DataSet = cdsCliCtt
    Left = 584
    Top = 27
  end
end
