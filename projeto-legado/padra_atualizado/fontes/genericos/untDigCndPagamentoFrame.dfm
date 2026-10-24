object fraDigCndPagamento: TfraDigCndPagamento
  Left = 0
  Top = 0
  Width = 725
  Height = 350
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 725
    Height = 350
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlCndPag: TPanel
      Left = 2
      Top = 26
      Width = 721
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCndPag: TLabel
        Left = 37
        Top = 18
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cond. Pagto.:'
      end
      object lblObs: TLabel
        Left = 597
        Top = 1
        Width = 109
        Height = 13
        Alignment = taRightJustify
        Caption = 'Informa'#231#245'es adicionais'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 108
        Top = 14
        Width = 65
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object mskCndPag: TMaskEditFocus
        Tag = 99
        Left = 108
        Top = 14
        Width = 598
        Height = 21
        CharCase = ecUpperCase
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        TabOrder = 1
        Text = ''
        OnEnter = mskCndPagEnter
        OnExit = mskCndPagExit
        OnKeyDown = mskCndPagKeyDown
        OnKeyPress = mskCndPagKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object pnlTrocarCondPagamento: TPanel
        Left = 8
        Top = 0
        Width = 465
        Height = 13
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        Visible = False
        object lblTrocarCondPagamento: TLabel
          Left = 108
          Top = 0
          Width = 346
          Height = 13
          Caption = 
            'Trocar por esta Cond. de Pagamento far'#225' produtos sa'#237'rem da promo' +
            #231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 33023
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          StyleElements = [seClient, seBorder]
        end
        object imgAlerta: TImage
          Left = 89
          Top = -1
          Width = 16
          Height = 16
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            0000001008060000001FF3FF610000001974455874536F667477617265004164
            6F626520496D616765526561647971C9653C0000001B744558745469746C6500
            5761726E696E673B4E6F74696669636174696F6E3BB6E7798600000241494441
            54785EA58F5F48536118C64FC5A02E9288EE2BA8816585ABFC83DA28EBA6CB6A
            12CC300BA2024D27589A0CB4ADA4DC859995D36DD1A4CD5DA428E94636D7E98F
            D236D79A04DBB42E14664E735B46E982A7F73BD448362FA40F7E9C87F77D7EE7
            7C87F3EA8EFE179C475B98123A6BDC0F8F9410729657ECB91F1C4E8209439A82
            3CCA7162C9DE949F4D3975F7DD5D69129D57F76F1A69967E9E1E7D8C90CB00CA
            7E7D55665AAA2E37AC2958069DB5FCED7C63D0AAC6AF6F9F108F05101C508166
            3AB64BEABF6ECC4BC0AE6EABCF29766AE588935C76A51AE5443CE287B3ED349E
            37E4C8586799E368C84DD0A5906C1FAACF9D0FB98C589A0F407EE682C062D883
            A9B76DA0DD9CA952B2F55F871BACCB12A83CBE4D64AB3DC87B9F5409C28F4907
            2A2B140C217F9FE886C7580EEA0C49D337AFFBEB71D6EA03C2D57B15923A5E23
            A32F8F233A66C042B01BFA961B30102C477D3A7A491FF8A693A06E0D7304F759
            452667BEB8279B9E8B730107621F3B11713523EA6EC5F4700B43C8C2CCDB8E49
            BE15AC4B4E1673B93BA776A6F55CDE17F49A9588BE6F4778508159470D621F1E
            41A3563258A6592DC22FAAF0F58D1A23F74B418EBFF1C48E8D9CE57C86DE7E53
            8688CF84195B19A6FB4A05623E230E498F31584ECCBF0C5CC20C7F0BD6EB85E8
            3A97D1C1594A768527FA5588B8B59877DE436CCC44FF6AC3CFD028A2213F2253
            5E2C8CF70BBBB9572A84EDD730FBB21EC15E2598CBE98AC43DE6E274A4C27276
            AFC04AFB8E22F1538ECE16424CEC5E25E23F2E2722D6131B56097344BF0168AD
            F1039DB8E68C0000000049454E44AE426082}
        end
      end
    end
    object pnlForPag: TPanel
      Left = 2
      Top = 61
      Width = 721
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label2: TLabel
        Left = 25
        Top = 5
        Width = 80
        Height = 13
        Alignment = taRightJustify
        Caption = 'Forma de Pagto:'
      end
      object edtForPag: TEditFocus
        Tag = 99
        Left = 108
        Top = 1
        Width = 65
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtForPagKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesForPag: TEditFocus
        Left = 175
        Top = 1
        Width = 531
        Height = 21
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
    end
    object pnlDados: TPanel
      Left = 2
      Top = 109
      Width = 721
      Height = 224
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object Label1: TLabel
        Left = 448
        Top = 204
        Width = 127
        Height = 13
        Caption = 'Valor Total das Duplicatas:'
      end
      object dbgDupAgru: TDBGridCitel
        Left = 3
        Top = 1
        Width = 703
        Height = 193
        TabStop = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CTR_NUMDUP'
            Title.Caption = 'Duplicata'
            Width = 144
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CTR_ESPDOC'
            Title.Caption = 'Esp'#233'cie'
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CTR_CODEMP'
            Title.Caption = 'Empresa'
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CTR_DTAVEN'
            Title.Caption = 'Vencimento'
            Width = 132
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'CTR_VALDUP'
            Title.Caption = 'Valor'
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            Title.Caption = 'Vlr. Corrigido'
            Visible = False
          end>
      end
      object edtTotDup: TEditFocus
        Left = 586
        Top = 200
        Width = 120
        Height = 21
        Alignment = taRightJustify
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
    end
    object pnlChecks: TPanel
      Left = 2
      Top = 85
      Width = 721
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
      object lblPagamentoPix: TLabel
        Left = 429
        Top = 2
        Width = 175
        Height = 13
        Caption = 'Ser'#225' gerado um Pix para pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
        StyleElements = [seClient, seBorder]
      end
      object chkZerTax: TCheckBox
        Left = 108
        Top = 0
        Width = 114
        Height = 18
        Caption = '&Zera Taxa de Juros'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnClick = chkZerTaxClick
      end
      object chkManPre: TCheckBox
        Left = 222
        Top = 0
        Width = 209
        Height = 18
        Caption = '&Manter Pre'#231'os Informados na Digita'#231#227'o'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        OnClick = chkManPreClick
      end
    end
    object pnlPrevisao: TPanel
      Left = 2
      Top = 2
      Width = 721
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblPreVis: TLabel
        Left = 60
        Top = 7
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Previs'#227'o:'
      end
      object mskPreVis: TMaskEditFocus
        Tag = 99
        Left = 108
        Top = 2
        Width = 65
        Height = 21
        BiDiMode = bdLeftToRight
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentBiDiMode = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object chkCndPagTodos: TCheckBox
      Left = 526
      Top = 78
      Width = 346
      Height = 12
      Caption = 
        'Utilizar condi'#231#227'o de pagamento para todos os clientes selecionad' +
        'os'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = chkZerTaxClick
    end
  end
end
