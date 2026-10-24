inherited frmFatDadosFiscais: TfrmFatDadosFiscais
  Left = 191
  Top = 83
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Dados Fiscais'
  ClientHeight = 889
  ClientWidth = 711
  Position = poMainFormCenter
  ExplicitWidth = 717
  ExplicitHeight = 918
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 799
    Width = 711
    TabOrder = 15
    ExplicitTop = 799
    ExplicitWidth = 711
    DesignSize = (
      711
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 707
      ExplicitWidth = 707
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 873
    Width = 711
    TabOrder = 14
    ExplicitTop = 873
    ExplicitWidth = 711
    inherited pnlNomeForm: TPanel
      Left = 580
      Width = 131
      ExplicitLeft = 580
      ExplicitWidth = 131
    end
    inherited pnlInfo: TPanel
      Width = 130
      ExplicitWidth = 130
    end
    inherited pnlBotoesTrace: TPanel
      TabOrder = 3
    end
    object pnlProgresso: TPanel
      Left = 130
      Top = 0
      Width = 450
      Height = 16
      Align = alRight
      BevelInner = bvLowered
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      Visible = False
      object pgbProgresso: TGauge
        Left = 323
        Top = 2
        Width = 125
        Height = 12
        Align = alClient
        ForeColor = clNavy
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Progress = 100
        ExplicitLeft = 260
        ExplicitWidth = 188
      end
      object lblProgresso: TLabel
        Left = 2
        Top = 2
        Width = 321
        Height = 12
        Align = alLeft
        AutoSize = False
        Caption = '...'
        Layout = tlCenter
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 559
    Width = 711
    Height = 0
    Align = alNone
    TabOrder = 13
    Visible = False
    ExplicitTop = 559
    ExplicitWidth = 711
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 703
      ExplicitHeight = 428
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 847
    Width = 711
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 16
    object btnCancelaDados: TBitBtnLocked
      Left = 632
      Top = 2
      Width = 77
      Height = 22
      Align = alRight
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
    object FlwPblConfirma: TFlowPanel
      Left = 2
      Top = 2
      Width = 630
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirmaDados: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Confirma'
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
        OnClick = btnConfirmaDadosClick
      end
      object btnDigImpostosItens: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 120
        Height = 22
        Caption = 'Digitar &Impostos'
        Glyph.Data = {
          F2010000424DF201000000000000F20000002800000010000000100000000100
          08000000000000010000340B0000340B00002F0000002F000000EA8F3100B66A
          5000AB735800C07B5800EAA15800FFB65800AB6A6000B67B6000C08460006A6A
          6A00A16A6A00A1736A00C0846A006AFF6A00A17B7300B68F7B00F4C07B00B68F
          8400F4C08400F4CA8400B6988F00C0988F00F4CA8F00B6AB9800F4CA9800D4AB
          A100D4B6A100E0B6A100EAB6A100EAC0A100F4D4A100FFD4A100EAC0AB00F4D4
          AB00F4E0B600E0C0C000E0CAC000E0CACA00F4E0CA00FFEACA00FFEAD400FFF4
          E000FFF4EA00FFF4F400FFFFF400FF00FF00FFFFFF002D2D0A0A0A0A0A0A0A0A
          0A0A0A0A0A2D2D2D112722211E181612101010130A2D2D2D1127090909090909
          090909120A2D2D2D14290D0D0D0D0D0D0D0D0D120A2D2D2D14290D0D0D0D0D0D
          0D0D0D100A2D2D2D142C090909090909090909120A2D2D2D1A2E0D0D0D0D0D0D
          0D0D0D0D0A2D2D2D1A2E0D0D0D0D0D0D0D0D0D0D0A2D2D2D1A2E090909090909
          0909091E0A2D2D2D192E0D0D0D0D0D0D0D0D0D1E0A2D2D2D1A2E0D0D0D0D0D0D
          0D0D0D170A2D2D2D1B2E09090909092A260F0E0B0A2D2D2D1B2E0D0D0D0D0D0D
          23020400012D2D2D202E0D0D0D0D0D0D240705032D2D2D2D1B2B2A2A2A2A2A2A
          23070C2D2D2D2D2D1B1D1D1D1D1B1B1D19062D2D2D2D}
        TabOrder = 1
        OnClick = btnDigImpostosItensClick
      end
      object btnDadAdi: TBitBtnLocked
        Left = 197
        Top = 0
        Width = 106
        Height = 22
        Caption = '&Dados Adicionais'
        TabOrder = 2
        OnClick = btnDadAdiClick
      end
      object btnMostraMargem: TBitBtnLocked
        Left = 303
        Top = 0
        Width = 103
        Height = 22
        Caption = '[ F4 ] Margem/Lucro'
        TabOrder = 3
        OnClick = btnMostraMargemClick
      end
      object btnVerImpostos: TBitBtnLocked
        Left = 406
        Top = 0
        Width = 111
        Height = 22
        Caption = '&Visualizar Impostos'
        TabOrder = 4
        OnClick = btnVerImpostosClick
      end
      object btnEspRascNF: TBitBtnLocked
        Left = 517
        Top = 0
        Width = 111
        Height = 22
        Caption = '&Espelho Rasc. DANFE'
        TabOrder = 5
        Visible = False
        OnClick = btnEspRascNFClick
      end
    end
  end
  object pnlTransportadora: TPanel [4]
    Left = 0
    Top = 0
    Width = 711
    Height = 194
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    inline fraDadosFechamentoVendaTransportadoraFrame: TfraDadosFechamentoVendaTransportadoraFrame
      Left = 1
      Top = 2
      Width = 710
      Height = 192
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 2
      ExplicitHeight = 192
      inherited pnlDados: TPanel
        Height = 192
        BevelOuter = bvRaised
        ExplicitHeight = 192
        inherited lblValorDoFrete: TLabel
          Left = 31
          Width = 71
          Height = 14
          ExplicitLeft = 31
          ExplicitWidth = 71
          ExplicitHeight = 14
        end
        inherited lblFretePorConta: TLabel
          Left = 225
          Width = 71
          Height = 14
          ExplicitLeft = 225
          ExplicitWidth = 71
          ExplicitHeight = 14
        end
        inherited lblQuantidade: TLabel
          Left = 44
          Width = 58
          Height = 14
          ExplicitLeft = 44
          ExplicitWidth = 58
          ExplicitHeight = 14
        end
        inherited lblEspecie: TLabel
          Left = 61
          Width = 41
          Height = 14
          ExplicitLeft = 61
          ExplicitWidth = 41
          ExplicitHeight = 14
        end
        inherited lblMarca: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblPesoBruto: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblPesoLiquido: TLabel
          Left = 401
          Width = 64
          Height = 14
          ExplicitLeft = 401
          ExplicitWidth = 64
          ExplicitHeight = 14
        end
        inherited lblDespAcessoria: TLabel
          Left = 537
          Width = 82
          Height = 14
          ExplicitLeft = 537
          ExplicitWidth = 82
          ExplicitHeight = 14
        end
        inherited btnCalcFreSug: TSpeedButton
          OnClick = btnCalcFreSugClick
        end
        inherited btnCalcVolume: TSpeedButton
          OnClick = btnCalcVolumeClick
        end
        inherited lblNumeracao: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblEdiPes: TLabel
          OnClick = lblEdiPesClick
        end
        inherited lblValFreCot: TLabel
          Left = 37
          Width = 65
          Height = 14
          ExplicitLeft = 37
          ExplicitWidth = 65
          ExplicitHeight = 14
        end
        inherited lblOutros: TLabel
          Left = 583
          Top = 30
          Width = 36
          Height = 14
          ExplicitLeft = 583
          ExplicitTop = 30
          ExplicitWidth = 36
          ExplicitHeight = 14
        end
        inherited edtValFre: TEditFocus
          Height = 22
          OnEnter = edtValFreEnter
          OnExit = edtValFreExit
          ExplicitHeight = 22
        end
        inherited edtQtdTra: TEditFocus
          Height = 22
          OnKeyPress = edtQtdTraKeyPress
          ExplicitHeight = 22
        end
        inherited edtEspTra: TEditFocus
          Width = 120
          Height = 22
          MaxLength = 25
          ExplicitWidth = 120
          ExplicitHeight = 22
        end
        inherited edtMarTra: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtPesLiq: TEditFocus
          Height = 22
          OnExit = edtPesLiqExit
          ExplicitHeight = 22
        end
        inherited edtPesBru: TEditFocus
          Height = 22
          OnExit = edtPesBruExit
          ExplicitHeight = 22
        end
        inherited edtDesAce: TEditFocus
          Height = 22
          OnChange = fraDadosFechamentoVendaTransportadoraFrameedtDesAceChange
          OnExit = edtDesAceExit
          ExplicitHeight = 22
        end
        inherited chkEntUrg: TCheckBox
          Left = 442
          ExplicitLeft = 442
        end
        inherited cmbTipFre: TComboBoxFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited btnDespesasFaturamento: TBitBtnLocked
          Top = 3
          OnClick = btnDespesasFaturamentoClick
          OnExit = edtDesAceExit
          ExplicitTop = 3
        end
        inherited edtNumera: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtValFreCot: TEditFocus
          Height = 22
          OnEnter = edtValFreEnter
          OnExit = edtValFreExit
          ExplicitHeight = 22
        end
        inherited pnlDadosAux: TPanel
          Left = 1
          Width = 708
          Height = 47
          ExplicitLeft = 1
          ExplicitWidth = 708
          ExplicitHeight = 47
          inherited lblNumConhecimento: TLabel
            Width = 70
            Height = 14
            ExplicitWidth = 70
            ExplicitHeight = 14
          end
          inherited lblPlacaVeiculo: TLabel
            Left = 34
            Width = 67
            Height = 14
            ExplicitLeft = 34
            ExplicitWidth = 67
            ExplicitHeight = 14
          end
          inherited lblTransportadora: TLabel
            Width = 78
            Height = 14
            ExplicitWidth = 78
            ExplicitHeight = 14
          end
          inherited chkEst_Dv: TCheckBox
            OnClick = chkEst_DvClick
          end
          inherited edtCodTra: TEditFocus
            Left = 104
            Height = 22
            OnKeyPress = edtCodTraKeyPress
            ExplicitLeft = 104
            ExplicitHeight = 22
          end
          inherited edtNConhe: TEditFocus
            Height = 22
            OnKeyPress = edtQtdTraKeyPress
            ExplicitHeight = 22
          end
          inherited edtNomTra: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited mskPlaFat: TMaskEditFocus
            Left = 104
            Width = 61
            EditMask = 'AAa-aa99;0; '
            ExplicitLeft = 104
            ExplicitWidth = 61
          end
          inherited chkRetornoPorRecusa: TCheckBox
            Caption = 'Nota Fiscal de Retorno por Recusa '
            OnClick = fraDadosFechamentoVendaTransportadoraFramechkRetornoPorRecusaClick
          end
        end
        inherited pnlVolumeSepExc: TPanel
          Left = 1
          Width = 708
          ExplicitLeft = 1
          ExplicitWidth = 708
          inherited lblQtdTraSepExc: TLabel
            Left = 10
            Font.Pitch = fpVariable
            ExplicitLeft = 10
          end
          inherited lblQtdTraSepNExc: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtQtdTraSepExc: TEditFocus
            Left = 104
            Font.Pitch = fpVariable
            ExplicitLeft = 104
          end
          inherited edtQtdTraSepNExc: TEditFocus
            Font.Pitch = fpVariable
          end
        end
        inherited pnlTraRedesp: TPanel
          Left = 1
          Top = 165
          Width = 708
          BevelOuter = bvNone
          ExplicitLeft = 1
          ExplicitTop = 165
          ExplicitWidth = 708
          inherited Label21: TLabel
            Width = 101
            Height = 14
            ExplicitWidth = 101
            ExplicitHeight = 14
          end
          inherited edtTraRedNom: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtTraRedCod: TEditFocus
            Left = 104
            Height = 22
            OnKeyPress = edtCodTraKeyPress
            ExplicitLeft = 104
            ExplicitHeight = 22
          end
        end
        inherited edtOutros: TEditFocus
          Top = 26
          Height = 22
          ExplicitTop = 26
          ExplicitHeight = 22
        end
        inherited btnHlpDes: TBitBtnLocked
          Top = 25
          Height = 24
          OnClick = fraDadosFechamentoVendaTransportadoraFramebtnHlpDesClick
          ExplicitTop = 25
          ExplicitHeight = 24
        end
      end
    end
  end
  object pnlMensagem: TPanel [5]
    Left = 0
    Top = 394
    Width = 711
    Height = 168
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    inline fraDadosFechamentoVendaClaFisFrame: TfraDadosFechamentoVendaClaFisFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 23
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 23
      inherited pnlDados: TPanel
        Width = 709
        Height = 23
        ExplicitWidth = 709
        ExplicitHeight = 23
        inherited lblClaFis: TLabel
          Left = 38
          Top = 5
          Width = 64
          Height = 14
          ExplicitLeft = 38
          ExplicitTop = 5
          ExplicitWidth = 64
          ExplicitHeight = 14
        end
        inherited btnNotExp: TSpeedButton
          Top = 1
          OnClick = btnNotExpClick
          ExplicitTop = 1
        end
        inherited edtClaFis: TEditFocus
          Top = 1
          Height = 22
          OnExit = edtClaFisExit
          OnKeyPress = edtClaFisKeyPress
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited edtClaFi2: TEditFocus
          Top = 1
          Height = 22
          OnKeyPress = edtClaFisKeyPress
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited edtClaFi3: TEditFocus
          Top = 1
          Height = 22
          OnKeyPress = edtClaFisKeyPress
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited cmbNatOpe: TComboBoxFocus
          Left = 167
          Top = 1
          Height = 22
          OnEnter = cmbNatOpeEnter
          OnExit = cmbNatOpeExit
          ExplicitLeft = 167
          ExplicitTop = 1
          ExplicitHeight = 22
        end
      end
    end
    inline fraDadosFechamentoVendaMSGFatFrame: TfraDadosFechamentoVendaMSGFatFrame
      Left = 1
      Top = 24
      Width = 709
      Height = 117
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 24
      ExplicitWidth = 709
      ExplicitHeight = 117
      inherited pnlDados: TPanel
        Width = 709
        Height = 117
        ExplicitWidth = 709
        ExplicitHeight = 117
        inherited lblMensagem: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited edtMens01: TEditFocus
          Height = 22
          OnExit = edtMens01Exit
          ExplicitHeight = 22
        end
        inherited edtMens02: TEditFocus
          Height = 22
          OnExit = edtMens02Exit
          ExplicitHeight = 22
        end
        inherited edtMens03: TEditFocus
          Left = 105
          Height = 22
          OnExit = edtMens03Exit
          ExplicitLeft = 105
          ExplicitHeight = 22
        end
        inherited edtMens04: TEditFocus
          Height = 22
          OnExit = edtMens04Exit
          ExplicitHeight = 22
        end
        inherited edtMens05: TEditFocus
          Height = 22
          OnExit = edtMens05Exit
          ExplicitHeight = 22
        end
      end
    end
    inline fraDadosFechamentoVendaPlanContasFrame: TfraDadosFechamentoVendaPlanContasFrame
      Left = 1
      Top = 141
      Width = 709
      Height = 26
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      ExplicitLeft = 1
      ExplicitTop = 141
      ExplicitWidth = 709
      inherited pnlDados: TPanel
        Width = 709
        ExplicitTop = 0
        ExplicitWidth = 709
        ExplicitHeight = 26
        inherited lblCentroCusto: TLabel
          Left = 18
          Width = 81
          Height = 14
          ExplicitLeft = 18
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited mskCodCta: TMaskEditFocus
          OnEnter = fraDadosFechamentoVendaPlanContasFramemskCodCtaEnter
          OnExit = fraDadosFechamentoVendaPlanContasFramemskCodCtaExit
          OnKeyPress = mskCodCtaKeyPress
        end
      end
    end
  end
  object pnlResImp: TPanel [6]
    Left = 0
    Top = 619
    Width = 711
    Height = 124
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 8
    inline fraDadosFechamentoVendaTotaisFrame: TfraDadosFechamentoVendaTotaisFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 122
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 122
      inherited pnlDados: TPanel
        Width = 709
        Align = alClient
        ExplicitWidth = 709
        inherited lblBaseICMS: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblBasIpi: TLabel
          Left = 61
          Width = 41
          Height = 14
          ExplicitLeft = 61
          ExplicitWidth = 41
          ExplicitHeight = 14
        end
        inherited lblBaseST: TLabel
          Left = 424
          Width = 43
          Height = 14
          ExplicitLeft = 424
          ExplicitWidth = 43
          ExplicitHeight = 14
        end
        inherited lblVlrICMS: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblValIpi: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblVlrST: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblBasIss: TLabel
          Left = 420
          Width = 47
          Height = 14
          ExplicitLeft = 420
          ExplicitWidth = 47
          ExplicitHeight = 14
        end
        inherited lblValIss: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblAlqIcm: TLabel
          Left = 326
          Width = 38
          Height = 14
          ExplicitLeft = 326
          ExplicitWidth = 38
          ExplicitHeight = 14
        end
        inherited lblCodSit: TLabel
          Width = 22
          Height = 14
          ExplicitWidth = 22
          ExplicitHeight = 14
        end
        inherited lblBaseFCPST: TLabel
          Left = 37
          Width = 65
          Height = 14
          ExplicitLeft = 37
          ExplicitWidth = 65
          ExplicitHeight = 14
        end
        inherited lblVlrFCPST: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblAlqFCPST: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblPerFCP: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblVlrFCP: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited edtBasIcm: TEditFocus
          Height = 22
          OnExit = edtBasIcmExit
          ExplicitHeight = 22
        end
        inherited edtBasIpi: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtBasRet: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtValIcm: TEditFocus
          Height = 22
          OnExit = edtValIcmExit
          ExplicitHeight = 22
        end
        inherited edtValIpi: TEditFocus
          Height = 22
          OnChange = edtValIpiChange
          ExplicitHeight = 22
        end
        inherited edtValRet: TEditFocus
          Height = 22
          OnExit = edtValRetExit
          ExplicitHeight = 22
        end
        inherited edtBasIss: TEditFocus
          Height = 22
          OnExit = fraDadosFechamentoVendaTotaisFrameedtBasIssExit
          ExplicitHeight = 22
        end
        inherited edtValIss: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtAlqIcm: TEditFocus
          Height = 22
          OnExit = edtAlqIcmExit
          ExplicitHeight = 22
        end
        inherited edtCodSit: TEditFocus
          Height = 22
          OnKeyPress = edtCodSitKeyPress
          ExplicitHeight = 22
        end
        inherited edtBasFCPST: TEditFocus
          Height = 22
          OnExit = edtBasFCPSTExit
          ExplicitHeight = 22
        end
        inherited edtValFCPST: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtAlqFCPST: TEditFocus
          Height = 22
          OnExit = edtAlqFCPSTExit
          ExplicitHeight = 22
        end
        inherited edtPerFCP: TEditFocus
          Height = 22
          Enabled = False
          OnExit = fraDadosFechamentoVendaTotaisFrameedtPerFCPExit
          ExplicitHeight = 22
        end
        inherited edtVlrFCP: TEditFocus
          Height = 22
          OnExit = fraDadosFechamentoVendaTotaisFrameedtVlrFCPExit
          ExplicitHeight = 22
        end
        inherited pnlPisCofinsDif: TPanel
          Width = 709
          ExplicitWidth = 709
          inherited lblCstIpi: TLabel
            Left = 64
            Width = 36
            Height = 14
            ExplicitLeft = 64
            ExplicitWidth = 36
            ExplicitHeight = 14
          end
          inherited lblCstPis: TLabel
            Left = 186
            Width = 41
            Height = 14
            ExplicitLeft = 186
            ExplicitWidth = 41
            ExplicitHeight = 14
          end
          inherited lblCstCof: TLabel
            Left = 301
            Width = 63
            Height = 14
            ExplicitLeft = 301
            ExplicitWidth = 63
            ExplicitHeight = 14
          end
          inherited lblPerDif: TLabel
            Left = 420
            Width = 47
            Height = 14
            Visible = True
            ExplicitLeft = 420
            ExplicitWidth = 47
            ExplicitHeight = 14
          end
          inherited lblValDif: TLabel
            Height = 14
            Visible = True
            ExplicitHeight = 14
          end
        inherited edtCstIpi: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtCstPis: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtCstCof: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtPerDif: TEditFocus
          Height = 22
          Visible = True
          OnExit = edtAlqIcmExit
          ExplicitHeight = 22
        end
        inherited edtValDif: TEditFocus
          Height = 22
          TabStop = False
          ReadOnly = True
          Visible = True
          OnExit = edtAlqIcmExit
          ExplicitHeight = 22
        end
      end
        inherited pnlImpostosReforma: TPanel
          Width = 709
          ExplicitWidth = 709
          inherited Label1: TLabel
            Left = 50
            Width = 52
            Height = 14
            ExplicitLeft = 50
            ExplicitWidth = 52
            ExplicitHeight = 14
          end
          inherited Label2: TLabel
            Left = 165
            Width = 41
            Height = 14
            ExplicitLeft = 165
            ExplicitWidth = 41
            ExplicitHeight = 14
          end
          inherited Label3: TLabel
            Left = 272
            Width = 47
            Height = 14
            ExplicitLeft = 272
            ExplicitWidth = 47
            ExplicitHeight = 14
          end
          inherited Label4: TLabel
            Left = 382
            Width = 36
            Height = 14
            ExplicitLeft = 382
            ExplicitWidth = 36
            ExplicitHeight = 14
          end
          inherited Label5: TLabel
            Height = 14
            ExplicitHeight = 14
          end
          inherited Label6: TLabel
            Height = 14
            ExplicitHeight = 14
          end
          inherited edtBaseCBS: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtValorCBS: TEditFocus
            Left = 208
            Height = 22
            ExplicitLeft = 208
            ExplicitHeight = 22
          end
          inherited edtBaseIBS: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtValorIBS: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtBaseIS: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtValorIS: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
        end
      end
    end
  end
  object pnlDesconto: TPanel [7]
    Left = 0
    Top = 799
    Width = 711
    Height = 30
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 11
    inline fraDadosFechamentoVendaTipoFaturamentoFrame: TfraDadosFechamentoVendaTipoFaturamentoFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 28
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 28
      inherited pnlDados: TPanel
        Width = 709
        Height = 28
        Align = alClient
        ExplicitWidth = 709
        ExplicitHeight = 28
        inherited lblTipoFaturamento: TLabel
          Left = 15
          Top = 8
          Width = 86
          Height = 14
          ExplicitLeft = 15
          ExplicitTop = 8
          ExplicitWidth = 86
          ExplicitHeight = 14
        end
        inherited lblDescontoPercentual: TLabel
          Left = 422
          Top = 8
          Width = 70
          Height = 14
          ExplicitLeft = 422
          ExplicitTop = 8
          ExplicitWidth = 70
          ExplicitHeight = 14
        end
        inherited lblDescontoEspecial: TLabel
          Left = 244
          Top = 8
          Width = 92
          Height = 14
          ExplicitLeft = 244
          ExplicitTop = 8
          ExplicitWidth = 92
          ExplicitHeight = 14
        end
        inherited lblTotalGeral: TLabel
          Left = 547
          Top = 8
          Width = 54
          Height = 14
          ExplicitLeft = 547
          ExplicitTop = 8
          ExplicitWidth = 54
          ExplicitHeight = 14
        end
        inherited imgAlerta: TImage
          Left = 386
          ExplicitLeft = 386
        end
        inherited edtTipFat: TEditFocus
          Top = 4
          Height = 22
          ExplicitTop = 4
          ExplicitHeight = 22
        end
        inherited edtPorDes: TEditFocus
          Top = 4
          Height = 22
          ExplicitTop = 4
          ExplicitHeight = 22
        end
        inherited edtDesEsp: TEditFocus
          Left = 338
          Top = 4
          Height = 22
          ExplicitLeft = 338
          ExplicitTop = 4
          ExplicitHeight = 22
        end
        inherited edtTotGer: TEditFocus
          Top = 4
          Height = 22
          OnExit = edtTotGerExit
          ExplicitTop = 4
          ExplicitHeight = 22
        end
      end
    end
  end
  object pnlGravaFinanceiro: TPanel [8]
    Left = 0
    Top = 829
    Width = 711
    Height = 18
    Align = alBottom
    ParentBackground = False
    ParentColor = True
    TabOrder = 12
    Visible = False
    inline fraDadosFechamentoVendaGravarContasFrame: TfraDadosFechamentoVendaGravarContasFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 16
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 16
      inherited pnlDados: TPanel
        Width = 709
        Height = 16
        Align = alClient
        ExplicitWidth = 709
        ExplicitHeight = 16
        inherited ckbOFGravaCTP: TCheckBox
          Top = 0
          OnClick = ckbOFGravaCTPClick
          ExplicitTop = 0
        end
        inherited ckbGravaCTR: TCheckBox
          Top = 0
          OnClick = ckbGravaCTRClick
          ExplicitTop = 0
        end
      end
    end
  end
  object pnlMenExp: TPanel [9]
    Left = 0
    Top = 269
    Width = 711
    Height = 97
    Align = alTop
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    inline fraDadosFechamentoVendaMSGExpFrame: TfraDadosFechamentoVendaMSGExpFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 95
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 95
      inherited pnlDados: TPanel
        Width = 709
        ExplicitTop = 0
        ExplicitWidth = 709
        inherited lblObsExpedicao: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited edtMenExp: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtMenEx2: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtMenEx3: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
        inherited edtMenEx4: TEditFocus
          Height = 22
          ExplicitHeight = 22
        end
      end
    end
  end
  object pnlEvento: TPanel [10]
    Left = 0
    Top = 366
    Width = 711
    Height = 28
    Align = alTop
    ParentColor = True
    TabOrder = 4
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 10
      Top = 3
      Width = 686
      Height = 22
      TabOrder = 0
      ExplicitLeft = 10
      ExplicitTop = 3
      ExplicitWidth = 686
      inherited lblEventos: TLabel
        Width = 87
        Height = 14
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 62
        Height = 22
        ExplicitWidth = 62
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 158
        Width = 516
        Height = 22
        ExplicitLeft = 158
        ExplicitWidth = 516
        ExplicitHeight = 22
      end
    end
  end
  object pnlDadSer: TPanel [11]
    Left = 0
    Top = 194
    Width = 711
    Height = 27
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    Visible = False
    inline fraDadosFechamentoVendaObraFrame: TfraDadosFechamentoVendaObraFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 25
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 25
      inherited pnlDados: TPanel
        Width = 709
        Height = 25
        Align = alClient
        ExplicitWidth = 709
        ExplicitHeight = 25
        inherited lblCodigoObra: TLabel
          Left = 49
          Width = 52
          Height = 14
          ExplicitLeft = 49
          ExplicitWidth = 52
          ExplicitHeight = 14
        end
        inherited lblCodigoART: TLabel
          Left = 195
          Top = 5
          Width = 47
          Height = 14
          ExplicitLeft = 195
          ExplicitTop = 5
          ExplicitWidth = 47
          ExplicitHeight = 14
        end
        inherited Label1: TLabel
          Left = 326
          Top = 5
          Width = 43
          Height = 14
          ExplicitLeft = 326
          ExplicitTop = 5
          ExplicitWidth = 43
          ExplicitHeight = 14
        end
        inherited Label2: TLabel
          Left = 461
          Top = 6
          Width = 48
          Height = 14
          ExplicitLeft = 461
          ExplicitTop = 6
          ExplicitWidth = 48
          ExplicitHeight = 14
        end
        inherited Label3: TLabel
          Left = 599
          Top = 5
          Width = 19
          Height = 14
          ExplicitLeft = 599
          ExplicitTop = 5
          ExplicitWidth = 19
          ExplicitHeight = 14
        end
        inherited edtCodObr: TEditFocus
          Left = 105
          Width = 77
          Height = 22
          OnKeyPress = edtQtdTraKeyPress
          ExplicitLeft = 105
          ExplicitWidth = 77
          ExplicitHeight = 22
        end
        inherited edtCodART: TEditFocus
          Left = 246
          Height = 22
          OnKeyPress = edtQtdTraKeyPress
          ExplicitLeft = 246
          ExplicitHeight = 22
        end
        inherited edtCodCno: TEditFocus
          Left = 372
          Height = 22
          ExplicitLeft = 372
          ExplicitHeight = 22
        end
        inherited edtInsImo: TEditFocus
          Left = 512
          Top = 1
          Height = 22
          ExplicitLeft = 512
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited edtCodCib: TEditFocus
          Left = 624
          Top = 1
          Height = 22
          ExplicitLeft = 624
          ExplicitTop = 1
          ExplicitHeight = 22
        end
      end
    end
  end
  object pnlBombeamento: TPanel [12]
    Left = 0
    Top = 221
    Width = 711
    Height = 48
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    Visible = False
    inline fraDadosFechamentoVendaBombeamentoFrame: TfraDadosFechamentoVendaBombeamentoFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 46
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 46
      inherited pnlDados: TPanel
        Width = 709
        ExplicitWidth = 709
        inherited lblTotalBombeamento: TLabel
          Left = 398
          Width = 179
          Height = 14
          ExplicitLeft = 398
          ExplicitWidth = 179
          ExplicitHeight = 14
        end
        inherited lblQtdBombeamento: TLabel
          Left = 4
          Width = 97
          Height = 14
          ExplicitLeft = 4
          ExplicitWidth = 97
          ExplicitHeight = 14
        end
        inherited lblPrecoBombeamento: TLabel
          Height = 14
          ExplicitHeight = 14
        end
        inherited lblRedISS: TLabel
          Left = 455
          Width = 186
          Height = 14
          ExplicitLeft = 455
          ExplicitWidth = 186
          ExplicitHeight = 14
        end
        inherited edtTotBom: TEditFocus
          Height = 22
          OnExit = edtQtdBomExit
          ExplicitHeight = 22
        end
        inherited edtQtdBom: TEditFocus
          Height = 22
          OnExit = edtQtdBomExit
          ExplicitHeight = 22
        end
        inherited edtPrcBom: TEditFocus
          Height = 22
          OnExit = edtQtdBomExit
          ExplicitHeight = 22
        end
        inherited chkTaxMin: TCheckBox
          OnClick = chkTaxMinClick
        end
        inherited edtRedISS: TEditFocus
          Height = 22
          OnExit = fraDadosFechamentoVendaBombeamentoFrameedtRedISSExit
          ExplicitHeight = 22
        end
      end
    end
  end
  object pnlProjeto: TPanel [13]
    Left = 0
    Top = 743
    Width = 711
    Height = 26
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 9
    inline fraDadosFechamentoVendaProjetoFrame: TfraDadosFechamentoVendaProjetoFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 24
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      inherited pnlDados: TPanel
        Width = 709
        Height = 24
        Align = alClient
        ExplicitTop = 0
        ExplicitWidth = 709
        ExplicitHeight = 24
        inherited lblProjetoCliente: TLabel
          Left = 13
          Top = 6
          Width = 86
          Height = 14
          ExplicitLeft = 13
          ExplicitTop = 6
          ExplicitWidth = 86
          ExplicitHeight = 14
        end
        inherited edtCodPrj: TEditFocus
          Top = 1
          OnKeyPress = edtCodPrjKeyPress
          ExplicitTop = 1
        end
        inherited edtDesPrj: TEditFocus
          Top = 1
          ExplicitTop = 1
        end
      end
    end
  end
  object pnlDrawBack: TPanel [14]
    Left = 0
    Top = 592
    Width = 711
    Height = 27
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 7
    inline fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame
      Left = 1
      Top = 0
      Width = 497
      Height = 27
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 1
    end
  end
  object pnlTipAte: TPanel [15]
    Left = 0
    Top = 799
    Width = 711
    Height = 25
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 10
    Visible = False
    object lblTipAte: TLabel
      Left = 0
      Top = 4
      Width = 100
      Height = 14
      Caption = 'Tipo de Atendimento:'
    end
    object edtDesTpa: TEditFocus
      Left = 161
      Top = 0
      Width = 350
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
    object edtCodTpa: TEditFocus
      Tag = 99
      Left = 105
      Top = 0
      Width = 55
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
      TabOrder = 0
      OnKeyPress = edtCodTpaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlRefDocDadosFiscais: TPanel [16]
    Left = 0
    Top = 562
    Width = 711
    Height = 30
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    inline fraReferenciarDocumentosExterior: TfraReferenciarDocumentosExterior
      Left = 4
      Top = 0
      Width = 497
      Height = 27
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 4
      inherited pnlRefDoc: TPanel
        inherited btnRefeDoc: TBitBtnLocked
          Left = 5
          Top = 1
          OnClick = fraReferenciarDocumentosExteriorbtnRefeDocClick
          ExplicitLeft = 5
          ExplicitTop = 1
        end
      end
    end
  end
  object pnlEmpfat: TPanel [17]
    Left = 0
    Top = 769
    Width = 711
    Height = 30
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 17
    inline fraEmpresaFaturamentoFrame1: TfraEmpresaFaturamentoFrame
      Left = 1
      Top = 1
      Width = 709
      Height = 28
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 709
      ExplicitHeight = 28
      inherited pnlEmpFatFrame: TPanel
        Width = 709
        Height = 28
        ExplicitWidth = 709
        ExplicitHeight = 28
        inherited lblEmpFat: TLabel
          Font.Pitch = fpVariable
        end
        inherited edtCodEmpFat: TEditFocus
          Left = 105
          Top = 2
          OnKeyPress = fraEmpresaFaturamentoFrame1edtCodEmpFatKeyPress
          ExplicitLeft = 105
          ExplicitTop = 2
        end
        inherited edtDesEmpFat: TEditFocus
          Left = 170
          Top = 3
          Width = 513
          Font.Pitch = fpVariable
          ExplicitLeft = 170
          ExplicitTop = 3
          ExplicitWidth = 513
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 484
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 88
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 532
    Top = 88
  end
  object tmrHideHints: TTimer
    OnTimer = tmrHideHintsTimer
    Left = 588
    Top = 88
  end
end
