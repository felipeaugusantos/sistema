inherited frmNovoCompromisso: TfrmNovoCompromisso
  Width = 522
  Height = 712
  BorderIcons = [biSystemMenu]
  Caption = 'Novo Compromisso'
  Position = poMainFormCenter
  ExplicitWidth = 522
  ExplicitHeight = 712
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 635
    Width = 516
    ExplicitTop = 635
    ExplicitWidth = 516
    DesignSize = (
      516
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 512
      ExplicitWidth = 512
    end
  end
  inherited pnlStatus: TPanel
    Top = 667
    Width = 516
    ExplicitTop = 667
    ExplicitWidth = 516
    inherited pnlNomeForm: TPanel
      Left = 345
      ExplicitLeft = 345
    end
    inherited pnlInfo: TPanel
      Width = 345
      ExplicitWidth = 345
    end
  end
  inherited pgcDados: TPageControl
    Top = 20
    Width = 516
    Height = 615
    ExplicitTop = 20
    ExplicitWidth = 516
    ExplicitHeight = 615
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 508
      ExplicitHeight = 583
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 20
    Width = 516
    Height = 615
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    object pnlInf: TPanel
      Left = 2
      Top = 337
      Width = 512
      Height = 184
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lblDescricao: TLabel
        Left = 10
        Top = 10
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
      end
      object mmoDesCom: TMemoFocus
        Left = 8
        Top = 25
        Width = 500
        Height = 150
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object pnlReplica: TPanel
      Left = 2
      Top = 521
      Width = 512
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object grpReplica: TGroupBox
        Left = 8
        Top = 3
        Width = 500
        Height = 84
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 36
          Width = 48
          Height = 14
          Caption = 'Dta. Inicial'
        end
        object Label2: TLabel
          Left = 85
          Top = 36
          Width = 44
          Height = 14
          Caption = 'Dta. Final'
        end
        object Label3: TLabel
          Left = 161
          Top = 36
          Width = 64
          Height = 14
          Caption = 'Periodicidade'
        end
        object chkReplic: TCheckBox
          Left = 3
          Top = 14
          Width = 207
          Height = 16
          Caption = 'Replicar compromisso para outros dias'
          TabOrder = 0
          OnClick = chkReplicClick
        end
        object edtDtaIni: TMaskEditFocus
          Tag = 99
          Left = 9
          Top = 50
          Width = 74
          Height = 22
          AutoSize = False
          Ctl3D = True
          Enabled = False
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentCtl3D = False
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtDtaFin: TMaskEditFocus
          Tag = 99
          Left = 85
          Top = 50
          Width = 74
          Height = 22
          AutoSize = False
          Ctl3D = True
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentCtl3D = False
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object chkDesSab: TCheckBox
          Left = 242
          Top = 43
          Width = 209
          Height = 16
          Caption = 'Desconsiderar S'#225'bados'
          TabOrder = 4
        end
        object chkDesDom: TCheckBox
          Left = 242
          Top = 59
          Width = 209
          Height = 16
          Caption = 'Desconsiderar Domingos e feriados'
          TabOrder = 5
        end
        object edtPeriod: TSpinEdit
          Tag = 99
          Left = 161
          Top = 50
          Width = 74
          Height = 23
          MaxLength = 3
          MaxValue = 999
          MinValue = 1
          TabOrder = 3
          Value = 1
        end
      end
    end
    object pnlSales: TPanel
      Left = 2
      Top = 53
      Width = 512
      Height = 284
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblCliente: TLabel
        Left = 8
        Top = 9
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lblObserv: TLabel
        Left = 8
        Top = 113
        Width = 60
        Height = 14
        Caption = 'Observa'#231#227'o'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 8
        Top = 26
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 8
        TabOrder = 0
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
        Left = 74
        Top = 26
        Width = 432
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object mmoObserv: TMemoFocus
        Left = 8
        Top = 128
        Width = 500
        Height = 150
        ScrollBars = ssVertical
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object rdgCatego: TRadioGroup
        Left = 8
        Top = 58
        Width = 498
        Height = 49
        Caption = 'Categoria'
        Columns = 5
        Items.Strings = (
          'Visita'
          'Liga'#231#227'o'
          'E-mail'
          'WhatsApp'
          'Outros')
        TabOrder = 1
        TabStop = True
      end
    end
    object pnlSup: TPanel
      Left = 2
      Top = 2
      Width = 512
      Height = 51
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl1: TLabel
        Left = 93
        Top = 8
        Width = 23
        Height = 14
        Caption = 'Hora'
      end
      object lbl2: TLabel
        Left = 161
        Top = 8
        Width = 65
        Height = 14
        Caption = 'Compromisso'
      end
      object lblPreVis: TLabel
        Left = 8
        Top = 8
        Width = 22
        Height = 14
        Caption = 'Data'
      end
      object edtDtaCom: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 22
        Width = 75
        Height = 22
        AutoSize = False
        Ctl3D = True
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentCtl3D = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtHorCom: TMaskEditFocus
        Tag = 99
        Left = 93
        Top = 22
        Width = 60
        Height = 22
        AutoSize = False
        Ctl3D = True
        EditMask = '!99:99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentCtl3D = False
        TabOrder = 1
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtTitCom: TEditFocus
        Tag = 99
        Left = 161
        Top = 22
        Width = 345
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = True
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 87
        ParentCtl3D = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlBotoes1: TPanel [4]
    Left = 0
    Top = 635
    Width = 516
    Height = 32
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 4
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 110
      Height = 22
      Caption = '[ F10 ] &Gravar'
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
    object btnCancel: TBitBtnLocked
      Left = 395
      Top = 5
      Width = 112
      Height = 22
      Caption = '[ ESC ] &Cancelar'
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
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlTitulo: TPanel [5]
    Left = 0
    Top = 0
    Width = 516
    Height = 20
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Novo Compromisso'
    Color = 16757606
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 144
  end
end
