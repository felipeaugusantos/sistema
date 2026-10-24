inherited frmEstornoComissaoProfissionais: TfrmEstornoComissaoProfissionais
  Left = 187
  Top = 160
  Width = 782
  Height = 554
  BorderIcons = [biSystemMenu]
  Caption = 'Estorno da Comiss'#227'o de Profissionais'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 782
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 509
    Width = 776
    ExplicitTop = 509
    ExplicitWidth = 776
    inherited FlwBotoes: TFlowPanel
      Width = 772
      ExplicitWidth = 772
    end
  end
  inherited pnlStatus: TPanel
    Top = 509
    Width = 776
    ExplicitTop = 509
    ExplicitWidth = 776
    inherited pnlNomeForm: TPanel
      Left = 500
      Width = 276
      ExplicitLeft = 500
      ExplicitWidth = 276
    end
    inherited pnlInfo: TPanel
      Width = 500
      ExplicitWidth = 500
    end
  end
  inherited pgcDados: TPageControl
    Width = 776
    Height = 509
    ExplicitWidth = 776
    ExplicitHeight = 509
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 768
      ExplicitHeight = 477
      object Panel1: TPanel
        Left = 0
        Top = 433
        Width = 768
        Height = 0
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clGray
        Enabled = False
        TabOrder = 0
        Visible = False
        DesignSize = (
          768
          0)
        object BitBtn1: TBitBtnLocked
          Left = 619
          Top = -25
          Width = 77
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = '&Sair'
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B0000000100000001000000520000006B
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
          TabOrder = 0
          OnClick = btnSairClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 433
        Width = 768
        Height = 16
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Panel3: TPanel
          Left = 621
          Top = 0
          Width = 147
          Height = 16
          Align = alRight
          BevelInner = bvLowered
          PopupMenu = PopupMenu1
          TabOrder = 0
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 621
          Height = 16
          Align = alClient
          BevelInner = bvLowered
          TabOrder = 1
        end
      end
      object pnlBotoesBaixa: TPanel
        Left = 0
        Top = 449
        Width = 768
        Height = 28
        Align = alBottom
        BevelInner = bvLowered
        Color = 16770261
        TabOrder = 2
        object button: TBitBtnLocked
          Left = 8
          Top = 4
          Width = 121
          Height = 21
          Caption = '[ F10 ] Confirma'
          TabOrder = 0
        end
        object btnSairBaixa: TBitBtnLocked
          Left = 675
          Top = 4
          Width = 111
          Height = 21
          Caption = '[ Esc ] Sair'
          TabOrder = 1
        end
        object btnMarcarTodos: TBitBtnLocked
          Left = 130
          Top = 4
          Width = 121
          Height = 21
          Caption = '[ F9 ] Marcar Todos'
          TabOrder = 2
        end
        object btnDesmTodos: TBitBtnLocked
          Left = 252
          Top = 4
          Width = 121
          Height = 21
          Caption = '[ F8 ] Desmarcar Todos'
          TabOrder = 3
        end
        object btnLocProx: TBitBtnLocked
          Left = 374
          Top = 4
          Width = 121
          Height = 21
          Caption = '[F6] Localiza Pr'#243'xima'
          TabOrder = 4
        end
        object Button23: TBitBtnLocked
          Left = 496
          Top = 4
          Width = 121
          Height = 21
          Caption = '[F5] Inicia Busca'
          TabOrder = 5
        end
      end
    end
  end
  object pnlFundoGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 776
    Height = 509
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 774
      Height = 56
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label6: TLabel
        Left = 19
        Top = 11
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Profissional:'
      end
      object Label26: TLabel
        Left = 40
        Top = 34
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object edtProfissional: TEditFocus
        Left = 161
        Top = 7
        Width = 304
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodPro: TEditFocus
        Tag = 99
        Left = 79
        Top = 7
        Width = 81
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnEnter = edtCodProEnter
        OnExit = edtCodProExit
        OnKeyPress = edtCodProKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object btnConsultar: TBitBtnLocked
        Left = 381
        Top = 29
        Width = 84
        Height = 24
        Caption = '&Carregar'
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
        TabOrder = 3
        OnClick = btnConsultarClick
      end
      object edtComPro: TEditFocus
        Tag = 99
        Left = 79
        Top = 30
        Width = 81
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 57
      Width = 768
      Height = 451
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object pnlTotais: TPanel
        Left = 0
        Top = 288
        Width = 768
        Height = 163
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 1
        object pnlTotal: TPanel
          Left = 2
          Top = 5
          Width = 764
          Height = 34
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = 16770261
          TabOrder = 0
          object Label23: TLabel
            Left = 314
            Top = 10
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total:'
          end
          object lblNumReg: TLabel
            Left = 8
            Top = 10
            Width = 79
            Height = 14
            Alignment = taRightJustify
            Caption = 'Nro. Comiss'#245'es:'
          end
          object edtTotNroCom: TEditFocus
            Left = 91
            Top = 6
            Width = 83
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTotValTot: TEditFocus
            Left = 342
            Top = 6
            Width = 83
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
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
        object pnlMenuBtn: TPanel
          Left = 2
          Top = 133
          Width = 764
          Height = 28
          Align = alBottom
          BevelInner = bvLowered
          Color = 16770261
          TabOrder = 1
          object btnSaida: TBitBtnLocked
            Left = 639
            Top = 4
            Width = 121
            Height = 21
            Caption = '[ Esc ] &Sair'
            TabOrder = 5
            OnClick = btnSaidaClick
          end
          object btnMarTds: TBitBtnLocked
            Left = 126
            Top = 4
            Width = 121
            Height = 21
            Caption = '[ F9 ] Marcar Todos'
            TabOrder = 1
            OnClick = btnMarTdsClick
          end
          object btnDesTds: TBitBtnLocked
            Left = 248
            Top = 4
            Width = 121
            Height = 21
            Caption = '[ F8 ] Desmarcar Todos'
            TabOrder = 2
            OnClick = btnDesTdsClick
          end
          object btnLocPro: TBitBtnLocked
            Left = 370
            Top = 4
            Width = 121
            Height = 21
            Caption = '[F7] Localiza Pr'#243'xima'
            Enabled = False
            TabOrder = 3
            OnClick = btnLocProClick
          end
          object btnIniBus: TBitBtnLocked
            Left = 492
            Top = 4
            Width = 121
            Height = 21
            Caption = '[F6] Inicia Busca'
            TabOrder = 4
            OnClick = btnIniBusClick
          end
          object btnConfirma: TBitBtnLocked
            Left = 4
            Top = 4
            Width = 121
            Height = 21
            Caption = '[ F10 ] Confima Estorno'
            TabOrder = 0
            OnClick = btnConfirmaClick
          end
        end
        object pnlInformativos: TPanel
          Left = 2
          Top = 39
          Width = 764
          Height = 94
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = 16770261
          TabOrder = 2
          object pnlSelecionados: TLabel
            Left = 2
            Top = 2
            Width = 760
            Height = 12
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'SELECIONADOS'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label17: TLabel
            Left = 8
            Top = 23
            Width = 79
            Height = 14
            Alignment = taRightJustify
            Caption = 'Nro. Comiss'#245'es:'
          end
          object Label19: TLabel
            Left = 34
            Top = 46
            Width = 53
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Total:'
          end
          object Bevel1: TBevel
            Left = 178
            Top = 22
            Width = 3
            Height = 59
            Shape = bsRightLine
            Style = bsRaised
          end
          object Label5: TLabel
            Left = 186
            Top = 23
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'd.Comiss'#227'o:'
          end
          object Label1: TLabel
            Left = 186
            Top = 46
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Cadastro:'
          end
          object Label4: TLabel
            Left = 378
            Top = 69
            Width = 20
            Height = 14
            Alignment = taRightJustify
            Caption = 'C/D:'
          end
          object Label7: TLabel
            Left = 478
            Top = 23
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Docum.:'
          end
          object lblValComiss: TLabel
            Left = 333
            Top = 46
            Width = 65
            Height = 14
            Alignment = taRightJustify
            Caption = 'Vr Comiss'#227'o:'
          end
          object Label10: TLabel
            Left = 349
            Top = 23
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Vr Venda:'
          end
          object Label11: TLabel
            Left = 482
            Top = 69
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cliente:'
          end
          object Label12: TLabel
            Left = 472
            Top = 46
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa:'
          end
          object Label13: TLabel
            Left = 636
            Top = 23
            Width = 41
            Height = 14
            Alignment = taRightJustify
            Caption = 'Esp'#233'cie:'
          end
          object lblTotComiss: TLabel
            Left = 12
            Top = 69
            Width = 75
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total Comiss'#227'o:'
          end
          object edtSelNroCom: TEditFocus
            Left = 90
            Top = 19
            Width = 83
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtSelValTot: TEditFocus
            Left = 90
            Top = 42
            Width = 83
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
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
          object edtCodCom: TEditFocus
            Left = 259
            Top = 19
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
          object edtDtaCad: TEditFocus
            Left = 259
            Top = 42
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
          object edtCreDeb: TEditFocus
            Left = 398
            Top = 65
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
          object edtNumDoc: TEditFocus
            Left = 518
            Top = 19
            Width = 99
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtValVen: TEditFocus
            Left = 398
            Top = 19
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
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
          object edtValCom: TEditFocus
            Left = 398
            Top = 42
            Width = 70
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 7
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCli: TEditFocus
            Left = 518
            Top = 65
            Width = 240
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 8
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEmp: TEditFocus
            Left = 518
            Top = 42
            Width = 240
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 9
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEspDoc: TEditFocus
            Left = 678
            Top = 19
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 10
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtSelTotCom: TEditFocus
            Left = 90
            Top = 65
            Width = 83
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 11
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
      object dbgComissoes: TDBGridCitel
        Left = 0
        Top = 0
        Width = 768
        Height = 288
        Align = alClient
        DataSource = dtsComPro
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgComissoesDrawColumnCell
        OnDblClick = dbgComissoesDblClick
        OnKeyDown = dbgComissoesKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 0
  end
  object PopupMenu1: TPopupMenu
    Left = 640
    Top = 40
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
  object dtsComPro: TDataSource
    Left = 640
    Top = 8
  end
  object cdsRecibo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 8
    object cdsReciboNOMREC: TStringField
      FieldName = 'NOMREC'
      Size = 60
    end
    object cdsReciboVALREC: TFloatField
      FieldName = 'VALREC'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsReciboVALEXT: TStringField
      FieldName = 'VALEXT'
      Size = 1000
    end
    object cdsReciboHISREC: TStringField
      FieldName = 'HISREC'
      Size = 200
    end
    object cdsReciboDTAREC: TStringField
      FieldName = 'DTAREC'
      Size = 100
    end
    object cdsReciboNOMASS: TStringField
      FieldName = 'NOMASS'
      Size = 40
    end
    object cdsReciboNROVIA: TIntegerField
      FieldName = 'NROVIA'
    end
    object cdsReciboVALTOT: TFloatField
      FieldName = 'VALTOT'
    end
    object cdsReciboVALIMP: TFloatField
      FieldName = 'VALIMP'
    end
    object cdsReciboNOMLIB: TStringField
      FieldName = 'NOMLIB'
      Size = 30
    end
    object cdsReciboNROREC: TStringField
      FieldName = 'NROREC'
      Size = 10
    end
    object cdsReciboNUMPIS: TStringField
      FieldName = 'NUMPIS'
      Size = 15
    end
    object cdsReciboMARCA_: TStringField
      FieldName = 'MARCA_'
      Size = 1
    end
    object cdsReciboHISREC_02: TStringField
      FieldName = 'HISREC_02'
      Size = 200
    end
    object cdsReciboHISREC_03: TStringField
      FieldName = 'HISREC_03'
      Size = 200
    end
  end
end
