inherited frmCadRecorrenciaOcorrencia: TfrmCadRecorrenciaOcorrencia
  Width = 500
  Height = 377
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro Recorr'#234'ncia de Ocorr'#234'ncia'
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 500
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 306
    Width = 494
    ExplicitTop = 306
    ExplicitWidth = 494
    inherited FlwBotoes: TFlowPanel
      Width = 490
      ExplicitWidth = 490
    end
    inherited btnSair: TBitBtnLocked
      Left = 411
      Top = 3
      ExplicitLeft = 411
      ExplicitTop = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 332
    Width = 494
    ExplicitTop = 332
    ExplicitWidth = 494
    inherited pnlNomeForm: TPanel
      Left = 323
      ExplicitLeft = 323
    end
    inherited pnlInfo: TPanel
      Width = 323
      ExplicitWidth = 323
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 494
    Height = 306
    Align = alClient
    TabOrder = 2
    object pnlIntervalo: TPanel
      Left = 1
      Top = 215
      Width = 492
      Height = 90
      Align = alBottom
      TabOrder = 1
      object pnlIntervaloRecorrencia: TPanel
        Left = 247
        Top = 1
        Width = 244
        Height = 88
        Align = alRight
        TabOrder = 1
        object lblQtdOcorrencias: TLabel
          Left = 90
          Top = 56
          Width = 60
          Height = 14
          Caption = 'Ocorr'#234'ncias'
        end
        object mskDtaTer: TMaskEditFocus
          Tag = 99
          Left = 11
          Top = 23
          Width = 70
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtNroOcoTer: TEditFocus
          Tag = 99
          Left = 11
          Top = 52
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
          EditFormat = '#,##0'
        end
      end
      object pnlTipoIntervaloRecorrencia: TPanel
        Left = 1
        Top = 1
        Width = 244
        Height = 88
        Align = alLeft
        TabOrder = 0
        object lblIntervalo: TLabel
          Left = 13
          Top = 6
          Width = 118
          Height = 14
          Caption = 'Intervalo de Recorr'#234'ncia'
        end
        object CheckListIntervaloOcorrencia: TCheckListBox
          Left = 13
          Top = 23
          Width = 219
          Height = 57
          ItemHeight = 14
          TabOrder = 0
          OnClick = CheckListIntervaloOcorrenciaClick
        end
      end
    end
    object pnlRecorrenciaFreq: TPanel
      Left = 1
      Top = 97
      Width = 492
      Height = 118
      Align = alClient
      TabOrder = 0
      object pnlRecorrencia: TPanel
        Left = 1
        Top = 1
        Width = 244
        Height = 116
        Align = alLeft
        TabOrder = 0
        DesignSize = (
          244
          116)
        object lblRecorrencia: TLabel
          Left = 12
          Top = 7
          Width = 59
          Height = 14
          Caption = 'Recorr'#234'ncia'
        end
        object CheckListTipoRecorrencia: TCheckListBox
          Left = 12
          Top = 24
          Width = 220
          Height = 84
          Anchors = [akLeft, akTop, akBottom]
          ItemHeight = 14
          TabOrder = 0
          OnClick = CheckListTipoRecorrenciaClick
        end
      end
      object pnlFrequencia: TPanel
        Left = 247
        Top = 1
        Width = 244
        Height = 116
        Align = alRight
        TabOrder = 1
        DesignSize = (
          244
          116)
        object lblFrequencia: TLabel
          Left = 11
          Top = 6
          Width = 54
          Height = 14
          Caption = 'Frequ'#234'ncia'
        end
        object lblDias1: TLabel
          Left = 15
          Top = 26
          Width = 34
          Height = 14
          Caption = 'A cada'
        end
        object lblDias2: TLabel
          Left = 130
          Top = 26
          Width = 20
          Height = 14
          Caption = 'dias'
        end
        object CheckListFrequencia: TCheckListBox
          Left = 11
          Top = 23
          Width = 220
          Height = 85
          Anchors = [akLeft, akTop, akBottom]
          ItemHeight = 14
          TabOrder = 0
          OnClick = CheckListFrequenciaClick
        end
        object edtQtdFre: TEditFocus
          Tag = 99
          Left = 55
          Top = 23
          Width = 69
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 1
          OnExit = edtQtdFreExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
          EditFormat = '#,##0'
        end
      end
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 492
      Height = 96
      Align = alTop
      TabOrder = 2
      object pnlUltPro: TPanel
        Left = 1
        Top = 35
        Width = 490
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblDataUltPro: TLabel
          Left = 14
          Top = 6
          Width = 109
          Height = 14
          Caption = #218'ltimo processamento:'
        end
        object mskDtaUltPro: TMaskEditFocus
          Tag = 99
          Left = 210
          Top = 2
          Width = 72
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskhraUltPro: TMaskEditFocus
          Tag = 99
          Left = 283
          Top = 2
          Width = 35
          Height = 22
          EditMask = '99:99;1;_'
          MaxLength = 5
          TabOrder = 1
          Text = '  :  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object pnlDataInicial: TPanel
        Left = 1
        Top = 1
        Width = 490
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblDtaInicial: TLabel
          Left = 13
          Top = 11
          Width = 192
          Height = 14
          Caption = 'Data inicial para gera'#231#227'o da ocorr'#234'ncia:'
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 210
          Top = 7
          Width = 72
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskHraIni: TMaskEditFocus
          Tag = 99
          Left = 283
          Top = 7
          Width = 35
          Height = 22
          EditMask = '99:99;1;_'
          MaxLength = 5
          TabOrder = 1
          Text = '  :  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object pnlOpcoes: TPanel
        Left = 1
        Top = 63
        Width = 490
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object chkGerarTodasOcorrencias: TCheckBox
          Left = 12
          Top = 6
          Width = 397
          Height = 17
          Caption = 'Gerar Todas Ocorr'#234'ncias'
          TabOrder = 0
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 120
  end
end
