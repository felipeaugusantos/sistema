inherited frmHistOcorrencias: TfrmHistOcorrencias
  Width = 545
  Height = 426
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Fluxo da Ocorr'#234'ncia'
  WindowState = wsMaximized
  ExplicitWidth = 545
  ExplicitHeight = 426
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 326
    Width = 529
    Height = 45
    ExplicitTop = 326
    ExplicitWidth = 529
    ExplicitHeight = 45
    inherited FlwBotoes: TFlowPanel
      Width = 525
      Height = 41
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 41
      inherited btnIncluir: TBitBtnLocked
        Width = 89
        Visible = False
        ExplicitWidth = 89
      end
      inherited btnGravar: TBitBtnLocked
        Left = 89
        Width = 89
        Anchors = [akTop, akRight]
        ExplicitLeft = 89
        ExplicitWidth = 89
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 178
        Width = 89
        Visible = False
        ExplicitLeft = 178
        ExplicitWidth = 89
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 267
        Width = 89
        Visible = False
        ExplicitLeft = 267
        ExplicitWidth = 89
      end
      inherited btnCancela: TBitBtnLocked
        Left = 356
        Width = 89
        Anchors = [akTop, akRight]
        ExplicitLeft = 356
        ExplicitWidth = 89
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 89
        Visible = False
        ExplicitLeft = 0
        ExplicitTop = 20
        ExplicitWidth = 89
      end
      object btnGravarEfinalizar: TBitBtnLocked
        Left = 89
        Top = 20
        Width = 121
        Height = 20
        Anchors = [akTop, akRight]
        Caption = 'Gravar e &Finalizar'
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
        TabOrder = 6
        OnClick = btnGravarEfinalizarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 449
      Top = 22
      Width = 76
      Height = 20
      ExplicitLeft = 449
      ExplicitTop = 22
      ExplicitWidth = 76
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 371
    Width = 529
    ExplicitTop = 371
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 357
      Width = 172
      ExplicitLeft = 357
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 357
      ExplicitWidth = 357
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 326
    ExplicitWidth = 529
    ExplicitHeight = 326
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 294
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 326
    Align = alClient
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    object pnlDatas: TPanel
      Left = 1
      Top = 1
      Width = 527
      Height = 64
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object grbDatas: TGroupBox
        Left = 1
        Top = 1
        Width = 525
        Height = 62
        Align = alClient
        Caption = 'Hor'#225'rios'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 6
          Top = 17
          Width = 75
          Height = 14
          Caption = 'Data Inclus'#227'o:'
        end
        object Label2: TLabel
          Left = 5
          Top = 40
          Width = 77
          Height = 14
          Caption = 'Hora Inclus'#227'o:'
        end
        object Label3: TLabel
          Left = 357
          Top = 17
          Width = 87
          Height = 14
          Caption = 'Data Conclus'#227'o:'
        end
        object Label4: TLabel
          Left = 356
          Top = 40
          Width = 89
          Height = 14
          Caption = 'Hora Conclus'#227'o:'
        end
        object Label7: TLabel
          Left = 165
          Top = 17
          Width = 107
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Agendamento:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 163
          Top = 40
          Width = 109
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hora Agendamento:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object shpLiberadoAlterarDtConclusao: TShape
          Left = 450
          Top = 12
          Width = 8
          Height = 22
        end
        object shpLiberadoAlterarHrConclusao: TShape
          Left = 450
          Top = 35
          Width = 8
          Height = 22
        end
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 150
          Top = 12
          Width = 3
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HIS_CODHIS'
          DataSource = dtsHisOco
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDtaInc: TDBEditFocus
          Tag = 99
          Left = 89
          Top = 12
          Width = 68
          Height = 22
          DataField = 'HIS_DTAINC'
          DataSource = dtsHisOco
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHorInc: TDBEditFocus
          Tag = 99
          Left = 89
          Top = 34
          Width = 68
          Height = 22
          DataField = 'HIS_HORINC'
          DataSource = dtsHisOco
          Enabled = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaCon: TDBEditFocus
          Tag = 99
          Left = 458
          Top = 12
          Width = 68
          Height = 22
          DataField = 'HIS_DTACON'
          DataSource = dtsHisOco
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHorCon: TDBEditFocus
          Tag = 99
          Left = 458
          Top = 35
          Width = 68
          Height = 22
          DataField = 'HIS_HORCON'
          DataSource = dtsHisOco
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaAge: TDBEditFocus
          Tag = 99
          Left = 279
          Top = 13
          Width = 68
          Height = 22
          DataField = 'HIS_DTAAGE'
          DataSource = dtsHisOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeHorAge: TDBEditFocus
          Tag = 99
          Left = 279
          Top = 36
          Width = 68
          Height = 22
          DataField = 'HIS_HORAGE'
          DataSource = dtsHisOco
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object pnlUsuario: TPanel
      Left = 1
      Top = 65
      Width = 527
      Height = 122
      Align = alTop
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object grbUsuario: TGroupBox
        Left = 1
        Top = 1
        Width = 525
        Height = 120
        Align = alClient
        Caption = 'Informa'#231#245'es Gerais'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label6: TLabel
          Left = 50
          Top = 26
          Width = 45
          Height = 14
          Caption = 'Usu'#225'rio:'
        end
        object Label10: TLabel
          Left = 13
          Top = 49
          Width = 82
          Height = 14
          Alignment = taRightJustify
          Caption = 'Complemento:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 46
          Top = 69
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object lblTipOco: TLabel
          Left = 68
          Top = 94
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbeOpeOco: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 21
          Width = 52
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HIS_CODOPE'
          DataSource = dtsHisOco
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeOpeOcoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesOpeOco: TEditFocus
          Left = 153
          Top = 21
          Width = 285
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
        object dbeComple: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 44
          Width = 52
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HIS_CODCOC'
          DataSource = dtsHisOco
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 2
          OnExit = dbeCompleExit
          OnKeyPress = dbeCompleKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeDesComple: TEditFocus
          Left = 153
          Top = 44
          Width = 285
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbeCodSit: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 67
          Width = 52
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HIS_CODSIT'
          DataSource = dtsHisOco
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 4
          OnKeyPress = dbeCodSitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesSit: TEditFocus
          Left = 153
          Top = 67
          Width = 285
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbeTipOco: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 90
          Width = 52
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HIS_CODTOC'
          DataSource = dtsHisOco
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          OnKeyPress = dbeTipOcoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesTipOco: TEditFocus
          Left = 153
          Top = 90
          Width = 285
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 244
      Width = 527
      Height = 81
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object dbmDescri: TDBMemoFocus
        Left = 1
        Top = 1
        Width = 525
        Height = 79
        Align = alClient
        DataField = 'HIS_DESCRI'
        DataSource = dtsHisOco
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 187
      Width = 527
      Height = 57
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object grbInfGerais: TGroupBox
        Left = 1
        Top = 1
        Width = 525
        Height = 55
        Align = alClient
        Caption = 'Informa'#231#245'es Gerais'
        TabOrder = 0
        object chkEnvEmail: TCheckBox
          Left = 16
          Top = 19
          Width = 340
          Height = 17
          Caption = 'Enviar ocorr'#234'ncia por e-mail - Cliente'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 0
          OnClick = chkEnvEmailClick
        end
        object chkEnvEmailDestino: TCheckBox
          Left = 16
          Top = 35
          Width = 331
          Height = 17
          Caption = 'Enviar ocorr'#234'ncia por e-mail - Usu'#225'rio Destino'
          Checked = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 1
        end
        object ChkEmerge: TCheckBox
          Left = 289
          Top = 34
          Width = 234
          Height = 17
          Caption = 'Alterar em Ocorr'#234'ncia Emergencial'
          TabOrder = 2
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 160
  end
  object dtsHisOco: TDataSource
    Left = 336
    Top = 160
  end
end
