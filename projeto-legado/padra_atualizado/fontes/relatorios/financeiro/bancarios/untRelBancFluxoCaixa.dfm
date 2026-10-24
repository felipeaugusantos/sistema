inherited frmRelBancFluxoCaixa: TfrmRelBancFluxoCaixa
  Left = 391
  Top = 239
  Width = 539
  Height = 600
  Caption = 'Relat'#243'rio de Fluxo de Caixa'
  OnClose = FormClose
  ExplicitWidth = 539
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 533
    ExplicitTop = 528
    ExplicitWidth = 533
    DesignSize = (
      533
      28)
    inherited btnSair: TBitBtnLocked
      Left = 450
      ExplicitLeft = 450
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 3
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 3
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 80
      Width = 84
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 80
      ExplicitWidth = 84
    end
  end
  inherited pnlDados: TPanel
    Width = 533
    Height = 528
    ExplicitWidth = 533
    ExplicitHeight = 528
    object Label27: TLabel [0]
      Left = 6
      Top = 129
      Width = 56
      Height = 14
      Caption = 'Saldo Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 6
      Top = 165
      Width = 113
      Height = 14
      Caption = 'Fator Desc. C. Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [2]
      Left = 6
      Top = 92
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblPortador: TLabel [3]
      Left = 6
      Top = 53
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [4]
      Left = 6
      Top = 203
      Width = 132
      Height = 14
      Caption = 'Dias p/ cons. cheques dep.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [5]
      Left = 175
      Top = 165
      Width = 125
      Height = 14
      Caption = 'Dias p/ cons. cart'#245'es rec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [6]
      Left = 395
      Top = 4
      Width = 126
      Height = 14
      Caption = 'Invent'#225'rio(s) financeiro(s)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [7]
      Left = 6
      Top = 405
      Width = 154
      Height = 14
      Caption = 'Previs'#227'o di'#225'ria de venda '#224' vista'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [8]
      Left = 178
      Top = 405
      Width = 159
      Height = 14
      Caption = 'Previs'#227'o di'#225'ria de venda a prazo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [9]
      Left = 6
      Top = 367
      Width = 283
      Height = 14
      Caption = 'Limite de dias de atraso para considerar Ctp / Ctr vencidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel [10]
      Left = 249
      Top = 422
      Width = 84
      Height = 14
      Caption = 'A partir de: (dias)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [11]
      Left = 175
      Top = 203
      Width = 182
      Height = 14
      Caption = 'Dias p/ computar no contas a receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 6
      Top = 481
      Width = 203
      Height = 43
      TabOrder = 15
      ExplicitLeft = 6
      ExplicitTop = 481
      ExplicitWidth = 203
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Top = 18
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 18
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 14
        ExplicitTop = 14
      end
    end
    object edtSalIni: TEditFocus
      Tag = 99
      Left = 6
      Top = 143
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = ',0.00'
    end
    object edtFator: TEditFocus
      Tag = 99
      Left = 6
      Top = 179
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      Text = '1,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 6
      Top = 106
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
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
    object gpbOpcao: TGroupBox
      Left = 211
      Top = 481
      Width = 178
      Height = 43
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 18
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 14
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtDesEmpresa: TEditFocus
      Left = 50
      Top = 106
      Width = 339
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortador: TEditFocus
      Left = 50
      Top = 67
      Width = 339
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 6
      Top = 67
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDiaCDe: TEditFocus
      Tag = 99
      Left = 6
      Top = 217
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object rdgEmpresa: TRadioGroup
      Left = 6
      Top = 443
      Width = 383
      Height = 35
      Caption = 'Empresa'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      TabOrder = 14
    end
    object edtDiaCRe: TEditFocus
      Tag = 99
      Left = 175
      Top = 179
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object lstArquivos: TCheckListBox
      Left = 395
      Top = 19
      Width = 132
      Height = 505
      OnClickCheck = lstArquivosClickCheck
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      ParentFont = False
      TabOrder = 19
      OnEnter = lstArquivosEnter
      OnKeyDown = lstArquivosKeyDown
    end
    object edtPreVis: TEditFocus
      Tag = 99
      Left = 6
      Top = 419
      Width = 67
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 11
      Text = '0,00'
      OnExit = edtPreVisExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnCalSalPor: TBitBtnLocked
      Left = 79
      Top = 142
      Width = 178
      Height = 23
      Caption = 'Carregar Saldo dos Portadores'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000130B0000130B0000000100000001000016769E000579
        A400FF00FF000E80AA001082AC000D8FBE001389B400188BB400148CB8001C8E
        B8001E92BC00208CB4002293BA003D9BBD000C9ECB001391C000149AC3001E9A
        C1001F9DCD0014AED90020A1C90024A5CC002BA3C9002CA4CE002CAACF003FA4
        C60032A5C90034A6CA003DA8CB0020A2D30024AED60027ACDD0027ADDF0028AD
        DE0033B1D50037B8DC000EB4E10031B4E3003FBBE70036BCEB0048A5C40043AB
        CC0050B2C9005CB8CC0048B0D2004EB5D50045BCD80060BAD70053BEE00008C9
        F50004CFFE001DC7F00002D2FF0007D1FF0009D0FE0014D3FE001ED7FF001CD8
        FF002AC7EB0039C8EC0027DAFF003ADBFF0051C0DE005CC1DD0067C4DE0075C6
        DF0047C5EF004EC3EA005ACFF40048D7F8005FD4F10059DCFA0068CAE60071D3
        E8006DD7F60052E2FF005AE5FF0065E1FD007CE4FB0079E8FF007DEBFF009796
        960099969600A39E9E00A0A0A000A5A3A300ABA0A000ABA1A100ACA2A200AEAF
        AF00B3A5A500B1B2B200B2B2B200B2B3B300BCBCBC00D8B6B600DCB5B400DDB6
        B400E1B7B500E0B8B60091C7D3008ACBE00090CEE10085DBEF0081DFF7008DEF
        FF0092EFFF0095EDFF009CF0FF00B0E1EC00ACECF900B5EFFC00C6C7C700E1E0
        E000E5E3E200E5E4E400E9E2E000E9E3E200ECE5E200EAE9E900000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        02141804020202020202020202161500101E220700291C0202020202021A2313
        0033451B3F4019020202020B002D673E3B383D46416D66000202022F2C306B69
        4C3C394B4F50121D1702020F1243686A492B2A3A353236312402020921264A64
        515151512E3437120E02020A20254451755D586251476C6F0D020208121F4251
        745B5860514E6E6528020202031D2751745B5861514D48010202020202060551
        765B586351110C0202020202020202517259575F510202020202020202020251
        5C5452565102020202020202020202517170555A510202020202020202020251
        73775E5351020202020202020202020251515151020202020202}
      TabOrder = 4
      TabStop = False
      OnClick = btnCalSalPorClick
    end
    object gpbPeriodo: TGroupBox
      Left = 6
      Top = 4
      Width = 383
      Height = 48
      Caption = 'VENCIMENTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label25: TLabel
        Left = 6
        Top = 21
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 164
        Top = 21
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 62
        Top = 18
        Width = 70
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 215
        Top = 18
        Width = 70
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object cbxChecks: TCheckListBox
      Left = 6
      Top = 243
      Width = 383
      Height = 118
      OnClickCheck = cbxChecksClickCheck
      BevelOuter = bvNone
      Ctl3D = False
      ItemHeight = 14
      Items.Strings = (
        'Incluir Previs'#227'o'
        'Utilizar invent'#225'rio financeiro'
        'Considerar Pedido de Compra'
        'Considerar Pedido de Venda'
        'Separar coluna do Cta.Pag. em Fornecedores e Despesas'
        'Exibir Cta.Receber / Cta.Pagar Vencidos (Apenas Sint'#233'tico)'
        'Quebra por dia'
        'Quebra por m'#234's (Anal'#237'tico apenas sem quebra por dia)'
        'Considerar Previs'#245'es Diarias no S'#225'bado'
        
          'Mostrar os ped. compra em aberto anterior a data inicial acumula' +
          'dos'
        'Exibir listagem de saldo dos portadores')
      ParentCtl3D = False
      TabOrder = 9
      OnKeyDown = cbxChecksKeyDown
    end
    object edtPrePra: TEditFocus
      Tag = 99
      Left = 175
      Top = 419
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 12
      Text = '0,00'
      OnExit = edtPrePraExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLimiteDias: TEditFocus
      Tag = 99
      Left = 6
      Top = 382
      Width = 49
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      ParentFont = False
      TabOrder = 10
      Text = '9999'
      OnExit = edtLimiteDiasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtPeriod: TEditFocus
      Tag = 99
      Left = 336
      Top = 419
      Width = 20
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 13
      Text = '30'
      OnExit = edtPeriodExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDiaRec: TEditFocus
      Tag = 99
      Left = 175
      Top = 217
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 533
    ExplicitTop = 556
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 362
      ExplicitLeft = 362
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
      inherited shpMultSel: TShape
        Left = 342
        Top = 2
        Anchors = [akRight, akBottom]
        ExplicitLeft = 342
        ExplicitTop = 2
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 56
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 400
    Top = 88
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 496
    Top = 88
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 464
    Top = 88
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 496
    Top = 120
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 464
    Top = 120
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 432
    Top = 120
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 464
    Top = 56
  end
  inherited frxGen: TfrxUserDataSet
    Left = 496
    Top = 56
  end
  inherited frxDesigner: TfrxDesigner
    Left = 496
    Top = 24
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 432
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 56
  end
  object svdExcel: TSaveDialog
    Filter = 'Arquivos Excel|*.xls'
    Left = 432
    Top = 24
  end
  object cdsFluCai: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 400
    Top = 120
    object cdsFluCaiFLU_AUTINC: TStringField
      FieldName = 'FLU_AUTINC'
    end
    object cdsFluCaiFLU_TABELA: TStringField
      FieldName = 'FLU_TABELA'
    end
    object cdsFluCaiFLU_NUMDUP: TStringField
      FieldName = 'FLU_NUMDUP'
      Size = 12
    end
    object cdsFluCaiFLU_ESPDOC: TStringField
      FieldName = 'FLU_ESPDOC'
      Size = 2
    end
    object cdsFluCaiFLU_CODEMP: TStringField
      FieldName = 'FLU_CODEMP'
      Size = 3
    end
    object cdsFluCaiFLU_PARCEL: TStringField
      FieldName = 'FLU_PARCEL'
      Size = 1
    end
    object cdsFluCaiFLU_CODIGO: TStringField
      FieldName = 'FLU_CODIGO'
      Size = 8
    end
    object cdsFluCaiFLU_DESCRI: TStringField
      FieldName = 'FLU_DESCRI'
      Size = 50
    end
    object cdsFluCaiFLU_DTAVEN: TDateField
      FieldName = 'FLU_DTAVEN'
    end
    object cdsFluCaiFLU_CHQPRE: TFloatField
      FieldName = 'FLU_CHQPRE'
    end
    object cdsFluCaiFLU_CTAREC: TFloatField
      FieldName = 'FLU_CTAREC'
    end
    object cdsFluCaiFLU_MOVCAR: TFloatField
      FieldName = 'FLU_MOVCAR'
    end
    object cdsFluCaiFLU_CTAPAG: TFloatField
      FieldName = 'FLU_CTAPAG'
    end
    object cdsFluCaiFLU_PEDCOM: TFloatField
      FieldName = 'FLU_PEDCOM'
    end
    object cdsFluCaiFLU_ENTFLX: TStringField
      FieldName = 'FLU_ENTFLX'
      Size = 1
    end
    object cdsFluCaiFLU_PRECOM: TFloatField
      FieldName = 'FLU_PRECOM'
    end
    object cdsFluCaiFLU_PREVEN: TFloatField
      FieldName = 'FLU_PREVEN'
    end
    object cdsFluCaiFLU_PEDVEN: TFloatField
      FieldName = 'FLU_PEDVEN'
    end
    object cdsFluCaiFLU_CTADES: TFloatField
      FieldName = 'FLU_CTADES'
    end
    object cdsFluCaiFLU_CTAIMP: TFloatField
      FieldName = 'FLU_CTAIMP'
    end
    object cdsFluCaiFLU_DOCUME: TStringField
      FieldName = 'FLU_DOCUME'
      Size = 80
    end
    object cdsFluCaiANOMES: TStringField
      FieldName = 'ANOMES'
      Size = 10
    end
  end
  object dsListaPortadores: TDataSource
    Left = 438
    Top = 196
  end
  object cdsSalPor: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 264
    object cdsSalPorPOR_CODPOR: TStringField
      FieldName = 'POR_CODPOR'
      Size = 5
    end
    object cdsSalPorPOR_NOMPOR: TStringField
      FieldName = 'POR_NOMPOR'
      Size = 200
    end
    object cdsSalPorPOR_SALDOS: TFloatField
      FieldName = 'POR_SALDOS'
    end
  end
end
