inherited frmCadRapidoFreteTranspCidade: TfrmCadRapidoFreteTranspCidade
  Width = 1024
  Height = 637
  BorderStyle = bsSingle
  Caption = 'Cadastro R'#225'pido de Frete por Transportadora / Cidade'
  ExplicitWidth = 1024
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 566
    Width = 1018
    TabOrder = 3
    ExplicitTop = 566
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      inherited btnConfirma: TBitBtnLocked
        Width = 120
        Caption = 'Gra&var'
        ModalResult = 0
        ExplicitWidth = 120
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 894
      Top = 2
      Width = 120
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      ModalResult = 0
      ExplicitLeft = 894
      ExplicitTop = 2
      ExplicitWidth = 120
    end
  end
  inherited pnlStatus: TPanel
    Top = 592
    Width = 1018
    TabOrder = 4
    ExplicitTop = 592
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 328
    Width = 1018
    Height = 238
    Align = alBottom
    Enabled = False
    ParentColor = True
    TabOrder = 2
    object pgcGeral: TPageControl
      Left = 1
      Top = 1
      Width = 1016
      Height = 206
      ActivePage = tbsCalculoFrete
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tbsCalculoFrete: TTabSheet
        Caption = 'C'#225'lculo do Frete'
        object gpbCalculoFrete: TGroupBox
          Left = 0
          Top = 23
          Width = 1008
          Height = 151
          Align = alClient
          TabOrder = 1
          StyleElements = [seFont, seBorder]
          object Label2: TLabel
            Left = 55
            Top = 86
            Width = 104
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor m'#237'nimo do frete:'
          end
          object Label3: TLabel
            Left = 8
            Top = 109
            Width = 151
            Height = 14
            Alignment = taRightJustify
            Caption = 'Percentual sobre valor da nota:'
          end
          object Label4: TLabel
            Left = 384
            Top = 86
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor por Kilo:'
          end
          object Label5: TLabel
            Left = 553
            Top = 86
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor do ped'#225'gio a cada 100Kg:'
          end
          object Label6: TLabel
            Left = 808
            Top = 86
            Width = 105
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor m'#237'nimo do GRIS:'
          end
          object Label8: TLabel
            Left = 611
            Top = 109
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'Percentual do GRIS:'
          end
          object Label9: TLabel
            Left = 847
            Top = 109
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor da TAS:'
          end
          object Label31: TLabel
            Left = 81
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Transportadora:'
          end
          object Label7: TLabel
            Left = 123
            Top = 40
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cidade:'
          end
          object Label20: TLabel
            Left = 468
            Top = 40
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Estado:'
          end
          object lblValIse: TLabel
            Left = 574
            Top = 63
            Width = 133
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor da nota para isen'#231#227'o:'
          end
          object dbeMinFre: TDBEditFocus
            Tag = 99
            Left = 163
            Top = 82
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'MINFRE'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePerTot: TDBEditFocus
            Tag = 99
            Left = 163
            Top = 105
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PERTOT'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeValKil: TDBEditFocus
            Tag = 99
            Left = 455
            Top = 82
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'VALKIL'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 10
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePd100K: TDBEditFocus
            Tag = 99
            Left = 711
            Top = 82
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PD100K'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 12
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeMinGri: TDBEditFocus
            Tag = 99
            Left = 915
            Top = 82
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'MINGRI'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 14
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePerGri: TDBEditFocus
            Tag = 99
            Left = 711
            Top = 105
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PERGRI'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeValTas: TDBEditFocus
            Tag = 99
            Left = 915
            Top = 105
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'VALTAS'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 15
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeCodTra: TDBEditFocus
            Tag = 99
            Left = 163
            Top = 13
            Width = 50
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CODTRA'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeCodTraKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object edtNomTra: TEditFocus
            Left = 214
            Top = 13
            Width = 324
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
          object dbeCodCid: TDBEditFocus
            Tag = 99
            Left = 163
            Top = 36
            Width = 50
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CODCID'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            OnKeyPress = dbeCodCidKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtCidade: TEditFocus
            Left = 214
            Top = 36
            Width = 246
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
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
          object edtEstado: TEditFocus
            Left = 506
            Top = 36
            Width = 32
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 4
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeValIse: TDBEditFocus
            Tag = 99
            Left = 711
            Top = 59
            Width = 88
            Height = 22
            CharCase = ecUpperCase
            DataField = 'VALISE'
            DataSource = dscTraCid
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object pnlTomador: TPanel
            Left = 57
            Top = 58
            Width = 272
            Height = 24
            BevelOuter = bvNone
            TabOrder = 5
            object Label37: TLabel
              Left = 9
              Top = 5
              Width = 93
              Height = 14
              Alignment = taRightJustify
              Caption = 'Frete por Conta do:'
            end
            object ColorLabel1: TColorLabel
              Left = 146
              Top = 5
              Width = 116
              Height = 14
              Caption = '(E)mitente (D)estinat'#225'rio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object dbeTomado: TDBEditFocus
              Tag = 99
              Left = 106
              Top = 1
              Width = 35
              Height = 22
              CharCase = ecUpperCase
              DataField = 'TOMADO'
              DataSource = dscTraCid
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
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlCobVal: TPanel
            Left = 257
            Top = 104
            Width = 290
            Height = 25
            BevelOuter = bvNone
            TabOrder = 11
            object Label10: TLabel
              Left = 1
              Top = 5
              Width = 193
              Height = 14
              Alignment = taRightJustify
              Caption = 'Cobrar Valor por Kilo somente acima de:'
            end
            object dbeCobVal: TDBEditFocus
              Tag = 99
              Left = 198
              Top = 1
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              DataField = 'COBVAL'
              DataSource = dscTraCid
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentShowHint = False
              ShowHint = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              PanelInfo = pnlInfo
              TipoTexto = ttNumerico
            end
          end
          object pnlAliquo: TPanel
            Left = 807
            Top = 58
            Width = 197
            Height = 24
            BevelOuter = bvNone
            TabOrder = 7
            object Label11: TLabel
              Left = 22
              Top = 5
              Width = 84
              Height = 14
              Alignment = taRightJustify
              Caption = 'Al'#237'quota do ICMS:'
            end
            object dbeAliquo: TDBEditFocus
              Tag = 99
              Left = 108
              Top = 1
              Width = 88
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ALIQUO'
              DataSource = dscTraCid
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentShowHint = False
              ShowHint = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              PanelInfo = pnlInfo
              TipoTexto = ttNumerico
            end
          end
        end
        object chkReplicar: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 1002
          Height = 17
          Align = alTop
          Caption = 
            'Replicar os dados informados para todas as linhas listadas no gr' +
            'id'
          TabOrder = 0
          OnClick = chkReplicarClick
        end
      end
      object tbsFaixaFatDesc: TTabSheet
        Caption = 'Faixa de Faturamento x Desconto'
        ImageIndex = 1
        object cxgFaixas: TcxGridCitel
          Left = 0
          Top = 0
          Width = 1008
          Height = 174
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgFaixasTableView: TcxGridDBTableViewCitel
            OnKeyDown = cxgFaixasTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = False
            Navigator.Buttons.PriorPage.Visible = False
            Navigator.Buttons.Prior.Visible = False
            Navigator.Buttons.Next.Visible = False
            Navigator.Buttons.NextPage.Visible = False
            Navigator.Buttons.Last.Visible = False
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Append.Hint = 'Incluir'
            Navigator.Buttons.Append.Visible = True
            Navigator.Buttons.Delete.Hint = 'Excluir'
            Navigator.Buttons.Delete.Visible = True
            Navigator.Buttons.Edit.Hint = 'Alterar'
            Navigator.Buttons.Edit.Visible = True
            Navigator.Buttons.Post.Hint = 'Gravar'
            Navigator.Buttons.Post.Visible = True
            Navigator.Buttons.Cancel.Hint = 'Cancelar'
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = False
            Navigator.Buttons.SaveBookmark.Visible = False
            Navigator.Buttons.GotoBookmark.Visible = False
            Navigator.Buttons.Filter.Visible = False
            Navigator.Visible = True
            OnEditKeyDown = cxgFaixasTableViewEditKeyDown
            DataController.DataSource = dtsFaixas
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsBehavior.NavigatorHints = True
            OptionsBehavior.ExpandMasterRowOnDblClick = False
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.CancelOnExit = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgFaixasTableViewFATINI: TcxGridDBColumn
              Caption = 'Faturamento inicial'
              DataBinding.FieldName = 'FATINI'
              Width = 140
            end
            object cxgFaixasTableViewFATFIN: TcxGridDBColumn
              Caption = 'Faturamento final'
              DataBinding.FieldName = 'FATFIN'
              Width = 140
            end
            object cxgFaixasTableViewPERDES: TcxGridDBColumn
              Caption = 'Desconto sobre o frete (%)'
              DataBinding.FieldName = 'PERDES'
              Width = 140
            end
          end
          object cxgFaixasLevel: TcxGridLevel
            GridView = cxgFaixasTableView
          end
        end
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 207
      Width = 1016
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnAlterar: TBitBtnLocked
        Left = 792
        Top = 5
        Width = 72
        Height = 20
        Caption = '&Alterar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
          CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
          A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
          820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
          860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
          C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
          D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
          9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnAlterarClick
      end
      object btnCancela: TBitBtnLocked
        Left = 936
        Top = 5
        Width = 72
        Height = 20
        Caption = 'Cancela&r'
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
        TabOrder = 1
        OnClick = btnCancelaClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 864
        Top = 5
        Width = 72
        Height = 20
        Caption = '&Excluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnExcluirClick
      end
      object btnGravar: TBitBtnLocked
        Left = 720
        Top = 5
        Width = 72
        Height = 20
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
        TabOrder = 3
        OnClick = btnGravarClick
      end
      object btnIncluir: TBitBtnLocked
        Left = 648
        Top = 5
        Width = 72
        Height = 20
        Caption = '&Incluir'
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
        TabOrder = 4
        OnClick = btnIncluirClick
      end
    end
  end
  object cxFrete: TcxGridCitel [3]
    Left = 0
    Top = 41
    Width = 1018
    Height = 287
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 2
    ExplicitTop = 44
    object cxTblFrete: TcxGridDBTableViewCitel
      OnKeyUp = cxTblFreteKeyUp
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dscTraCid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxTblFreteCODTRA: TcxGridDBColumn
        Caption = 'C'#243'd.Transp.'
        DataBinding.FieldName = 'CODTRA'
        Width = 70
      end
      object cxTblFreteNOMTRA: TcxGridDBColumn
        DataBinding.FieldName = 'NOMTRA'
        Options.Editing = False
        Width = 100
      end
      object cxTblFreteCODCID: TcxGridDBColumn
        Caption = 'C'#243'd.Cid.'
        DataBinding.FieldName = 'CODCID'
        Width = 70
      end
      object cxTblFreteNOMCID: TcxGridDBColumn
        DataBinding.FieldName = 'NOMCID'
        Options.Editing = False
        Width = 100
      end
      object cxTblFreteESTADO: TcxGridDBColumn
        DataBinding.FieldName = 'ESTADO'
        Options.Editing = False
      end
      object cxTblFreteVALISE: TcxGridDBColumn
        DataBinding.FieldName = 'VALISE'
        Width = 90
      end
      object cxTblFreteMINFRE: TcxGridDBColumn
        DataBinding.FieldName = 'MINFRE'
        Width = 90
      end
      object cxTblFretePERTOT: TcxGridDBColumn
        DataBinding.FieldName = 'PERTOT'
        Width = 100
      end
      object cxTblFreteVALKIL: TcxGridDBColumn
        DataBinding.FieldName = 'VALKIL'
        Width = 90
      end
      object cxTblFretePD100K: TcxGridDBColumn
        DataBinding.FieldName = 'PD100K'
        Width = 140
      end
      object cxTblFretePERGRI: TcxGridDBColumn
        DataBinding.FieldName = 'PERGRI'
        Width = 90
      end
      object cxTblFreteMINGRI: TcxGridDBColumn
        DataBinding.FieldName = 'MINGRI'
        Width = 90
      end
      object cxTblFreteVALTAS: TcxGridDBColumn
        DataBinding.FieldName = 'VALTAS'
        Width = 90
      end
    end
    object cxFreteLvl: TcxGridLevel
      GridView = cxTblFrete
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 41
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object lblTraCid: TLabel
      Left = 12
      Top = 12
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora / Cidade:'
    end
    object lblEstadoTraCid: TLabel
      Left = 521
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object edtNomTraCid: TEditFocus
      Left = 189
      Top = 8
      Width = 324
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtEstadoTraCid: TEditFocus
      Left = 559
      Top = 8
      Width = 32
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodTraCid: TEditFocus
      Tag = 99
      Left = 138
      Top = 8
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodTraCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object pnlFreReg: TPanel
      Left = 593
      Top = 0
      Width = 422
      Height = 38
      BevelOuter = bvNone
      TabOrder = 3
      object lblFreReg: TLabel
        Left = 10
        Top = 12
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frete Regi'#227'o:'
      end
      object edtCodFreReg: TEditFocus
        Tag = 99
        Left = 75
        Top = 8
        Width = 50
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodFreRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomFreReg: TEditFocus
        Left = 126
        Top = 8
        Width = 289
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 928
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 852
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 852
    Top = 56
  end
  object cdsTraCid: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforeEdit = cdsTraCidBeforeEdit
    AfterScroll = cdsTraCidAfterScroll
    OnNewRecord = cdsTraCidNewRecord
    Left = 852
    Top = 108
    object cdsTraCidCODTRA: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'CODTRA'
      Size = 5
    end
    object cdsTraCidNOMTRA: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'NOMTRA'
      Size = 100
    end
    object cdsTraCidCODCID: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CODCID'
      Size = 5
    end
    object cdsTraCidNOMCID: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'NOMCID'
      Size = 100
    end
    object cdsTraCidESTADO: TStringField
      DisplayLabel = 'UF'
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsTraCidVALISE: TFloatField
      DisplayLabel = 'Vlr. Nota Isen'#231#227'o'
      FieldName = 'VALISE'
    end
    object cdsTraCidMINFRE: TFloatField
      DisplayLabel = 'Vlr. Min. Frete'
      FieldName = 'MINFRE'
    end
    object cdsTraCidPERTOT: TFloatField
      DisplayLabel = '% Sobre Vlr. Nota'
      FieldName = 'PERTOT'
    end
    object cdsTraCidVALKIL: TFloatField
      DisplayLabel = 'Vlr. por KG'
      FieldName = 'VALKIL'
    end
    object cdsTraCidPD100K: TFloatField
      DisplayLabel = 'Vlr. Ped'#225'gio (cada 100KG)'
      FieldName = 'PD100K'
    end
    object cdsTraCidPERGRI: TFloatField
      DisplayLabel = '% do GRIS'
      FieldName = 'PERGRI'
    end
    object cdsTraCidMINGRI: TFloatField
      DisplayLabel = 'Vlr. Min. GRIS'
      FieldName = 'MINGRI'
    end
    object cdsTraCidVALTAS: TFloatField
      DisplayLabel = 'Vlr. da TAS'
      FieldName = 'VALTAS'
    end
    object cdsTraCidTOMADO: TStringField
      DisplayLabel = 'Frete por Conta do'
      FieldName = 'TOMADO'
      Size = 1
    end
    object cdsTraCidCOBVAL: TFloatField
      DisplayLabel = 'Cobrar Vlr Kg Acima de'
      FieldName = 'COBVAL'
    end
    object cdsTraCidALIQUO: TFloatField
      DisplayLabel = 'Alq. ICMS'
      FieldName = 'ALIQUO'
    end
  end
  object dscTraCid: TDataSource
    DataSet = cdsTraCid
    Left = 928
    Top = 108
  end
  object dtsFaixas: TDataSource
    DataSet = cdsFaixas
    Left = 928
    Top = 172
  end
  object cdsFaixas: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FATINI'
    Params = <>
    BeforePost = cdsFaixasBeforePost
    OnNewRecord = cdsFaixasNewRecord
    Left = 852
    Top = 172
    object cdsFaixasCODTRA: TStringField
      FieldName = 'CODTRA'
      Size = 5
    end
    object cdsFaixasCODCID: TStringField
      FieldName = 'CODCID'
      Size = 5
    end
    object cdsFaixasFATINI: TFloatField
      FieldName = 'FATINI'
    end
    object cdsFaixasFATFIN: TFloatField
      FieldName = 'FATFIN'
    end
    object cdsFaixasPERDES: TFloatField
      FieldName = 'PERDES'
    end
  end
end
