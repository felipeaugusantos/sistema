inherited frmFatLazDigPreFor: TfrmFatLazDigPreFor
  Left = 187
  Top = 429
  Width = 311
  Height = 265
  ActiveControl = edtDilCon
  Caption = 'Digita'#231#227'o tipo pre'#231'o / Quarto f'#243'rmulas'
  Position = poScreenCenter
  ExplicitWidth = 311
  ExplicitHeight = 265
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 221
    Width = 305
    ExplicitTop = 221
    ExplicitWidth = 305
    DesignSize = (
      305
      0)
    inherited btnSair: TBitBtnLocked
      Left = 191
      ExplicitLeft = 191
    end
  end
  inherited pnlStatus: TPanel
    Top = 221
    Width = 305
    ExplicitTop = 221
    ExplicitWidth = 305
    inherited pnlNomeForm: TPanel
      Left = 166
      Width = 139
      ExplicitLeft = 166
      ExplicitWidth = 139
    end
    inherited pnlInfo: TPanel
      Width = 166
      ExplicitWidth = 166
    end
  end
  inherited pgcDados: TPageControl
    Width = 305
    Height = 221
    ExplicitWidth = 305
    ExplicitHeight = 221
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 297
      ExplicitHeight = 189
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 297
        Height = 161
        Align = alClient
        Color = 16770261
        TabOrder = 0
        object Label1: TLabel
          Left = 14
          Top = 21
          Width = 69
          Height = 14
          Caption = 'Tipo de Pre'#231'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object ColorLabel1: TColorLabel
          Left = 131
          Top = 21
          Width = 112
          Height = 14
          Caption = '(D)iluido (C)oncentrado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label2: TLabel
          Left = 47
          Top = 43
          Width = 36
          Height = 14
          Caption = 'Quarto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 68
          Top = 107
          Width = 17
          Height = 14
          Caption = 'ML:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDilCon: TEditFocus
          Tag = 99
          Left = 89
          Top = 14
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          OnChange = edtDilConChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
          Alignment = taLeftJustify
        end
        object chkMeioQuarto: TCheckBox
          Left = 90
          Top = 39
          Width = 88
          Height = 21
          Caption = '1/2 Quarto'
          TabOrder = 1
          OnClick = chkMeioQuartoClick
        end
        object chkUmQuarto: TCheckBox
          Left = 174
          Top = 39
          Width = 88
          Height = 21
          Caption = '1 Quarto'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkUmQuartoClick
        end
        object chkDoisQuartos: TCheckBox
          Left = 90
          Top = 60
          Width = 88
          Height = 21
          Caption = '2 Quartos'
          TabOrder = 3
          OnClick = chkDoisQuartosClick
        end
        object chkTresQuartos: TCheckBox
          Left = 174
          Top = 60
          Width = 88
          Height = 21
          Caption = '3 Quartos'
          TabOrder = 4
          OnClick = chkTresQuartosClick
        end
        object chkQuatroQuartos: TCheckBox
          Left = 90
          Top = 81
          Width = 88
          Height = 21
          Caption = '4 Quartos'
          TabOrder = 5
          OnClick = chkQuatroQuartosClick
        end
        object chk660ML: TCheckBox
          Left = 90
          Top = 105
          Width = 77
          Height = 21
          Caption = '660 ML'
          TabOrder = 6
          OnClick = chk660MLClick
        end
        object chk1320ML: TCheckBox
          Left = 175
          Top = 105
          Width = 88
          Height = 21
          Caption = '1320 ML'
          TabOrder = 7
          OnClick = chk1320MLClick
        end
        object chk2640ML: TCheckBox
          Left = 175
          Top = 129
          Width = 88
          Height = 21
          Caption = '2640 ML'
          TabOrder = 9
          OnClick = chk2640MLClick
        end
        object chk1980ML: TCheckBox
          Left = 90
          Top = 129
          Width = 75
          Height = 21
          Caption = '1980 ML'
          TabOrder = 8
          OnClick = chk1980MLClick
        end
      end
      object pnlConfirma: TPanel
        Left = 0
        Top = 161
        Width = 297
        Height = 28
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clGray
        TabOrder = 1
        object btnConfirmaDados: TBitBtnLocked
          Left = 4
          Top = 3
          Width = 77
          Height = 22
          Caption = '&Confirma'
          TabOrder = 0
          OnClick = btnConfirmaDadosClick
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
        end
        object btnCancelaDados: TBitBtnLocked
          Left = 215
          Top = 3
          Width = 77
          Height = 22
          Caption = 'C&ancelar'
          TabOrder = 1
          OnClick = btnCancelaClick
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
        end
      end
    end
  end
end
