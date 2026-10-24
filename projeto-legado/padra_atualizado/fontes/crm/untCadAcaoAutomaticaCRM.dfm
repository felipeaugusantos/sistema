inherited frmCadAcaoAutomaticaCRM: TfrmCadAcaoAutomaticaCRM
  Width = 812
  Height = 728
  Caption = 'Cadastro A'#231#245'es Autom'#225'ticas CRM'
  OnDestroy = FormDestroy
  ExplicitTop = -52
  ExplicitWidth = 812
  ExplicitHeight = 728
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 658
    Width = 806
    Height = 25
    ExplicitTop = 658
    ExplicitWidth = 806
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 725
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 725
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 100
        Height = 21
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 100
        Width = 100
        Height = 21
        ExplicitLeft = 100
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 200
        Width = 100
        Height = 21
        ExplicitLeft = 200
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 300
        Width = 100
        Height = 21
        ExplicitLeft = 300
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 400
        Width = 100
        Height = 21
        ExplicitLeft = 400
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 500
        Width = 100
        Height = 21
        ExplicitLeft = 500
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 727
      Height = 21
      Align = alRight
      ExplicitLeft = 727
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 683
    Width = 806
    ExplicitTop = 683
    ExplicitWidth = 806
    inherited pnlNomeForm: TPanel
      Left = 459
      ExplicitLeft = 459
    end
    inherited pnlInfo: TPanel
      Width = 459
      ExplicitWidth = 459
    end
  end
  inherited pgcDados: TPageControl
    Top = 87
    Width = 806
    Height = 571
    ActivePage = nil
    ExplicitTop = 87
    ExplicitWidth = 806
    ExplicitHeight = 571
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 798
      ExplicitHeight = 561
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 806
    Height = 87
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lblCodigo: TLabel
      Left = 36
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 20
      Top = 33
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblVigencia: TLabel
      Left = 27
      Top = 56
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vig'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblA: TLabel
      Left = 148
      Top = 56
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object ColorLabel51: TColorLabel
      Left = 661
      Top = 61
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
      CorDestaque = clRed
    end
    object ColorLabel52: TColorLabel
      Left = 716
      Top = 62
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object dbeDtaIni: TDBEditFocus
      Tag = 99
      Left = 74
      Top = 53
      Width = 68
      Height = 22
      DataField = 'ACA_DTAINI'
      DataSource = dtsTabela
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 74
      Top = 30
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ACA_DESCRI'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodAca: TDBEditFocus
      Tag = 99
      Left = 74
      Top = 7
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ACA_CODACA'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDtaFin: TDBEditFocus
      Tag = 99
      Left = 160
      Top = 53
      Width = 68
      Height = 22
      DataField = 'ACA_DTAFIN'
      DataSource = dtsTabela
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
    object dbeAtiva: TDBEditFocus
      Tag = 99
      Left = 692
      Top = 58
      Width = 23
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ACA_ATIVA'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  object gbxParametros: TGroupBox [4]
    Left = 0
    Top = 87
    Width = 806
    Height = 571
    Align = alClient
    Caption = 'Par'#226'metros'
    TabOrder = 3
    object pgcParametros: TPageControl
      Left = 2
      Top = 16
      Width = 802
      Height = 553
      ActivePage = tbsParCon
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      TabStop = False
      object tbsParCon: TTabSheet
        Caption = '&Filtros'
        inline fraCRMGeracaoGlobalFrameParametros: TfraCRMGeracaoGlobalFrameParametros
          Left = 0
          Top = 0
          Width = 794
          Height = 521
          Align = alClient
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          ExplicitWidth = 794
          ExplicitHeight = 521
          inherited pgcFiltros: TPageControl
            Width = 794
            Height = 521
            TabStop = False
            ExplicitWidth = 794
            ExplicitHeight = 521
            inherited tbsDadosContatoCliente: TTabSheet
              ExplicitLeft = 4
              ExplicitTop = 28
              ExplicitWidth = 782
              ExplicitHeight = 559
            end
            inherited tbsClientesSemCompra: TTabSheet
              ExplicitWidth = 786
              ExplicitHeight = 489
              inherited Label34: TLabel
                Top = 469
                Width = 786
                ExplicitTop = 469
              end
            end
            inherited tbsFinanceiro: TTabSheet
              ExplicitLeft = 4
              ExplicitTop = 28
              ExplicitWidth = 782
              ExplicitHeight = 559
              inherited fraCentroCusto: TfraCentroCustoEditFocus
                inherited edtCodEve: TEditFocus
                  OnExit = fraCentroCustoedtCodEveExit
                  OnKeyPress = fraCentroCustoedtCodEveKeyPress
                end
              end
            end
          end
        end
      end
      object tbsParCRM: TTabSheet
        Caption = '&Ocorr'#234'ncia CRM'
        ImageIndex = 1
        object Label10: TLabel
          Left = 5
          Top = 5
          Width = 102
          Height = 14
          Caption = 'Grupo de Ocorr'#234'ncia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodGoc: TEditFocus
          Tag = 99
          Left = 5
          Top = 20
          Width = 72
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodGocKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesGoc: TEditFocus
          Left = 78
          Top = 20
          Width = 300
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
        object gbxInformacoesGerais: TGroupBox
          Left = 5
          Top = 48
          Width = 466
          Height = 265
          Caption = 'Informa'#231#245'es Gerais'
          TabOrder = 2
          object Label11: TLabel
            Left = 51
            Top = 26
            Width = 23
            Height = 14
            Caption = 'Tipo:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 7
            Top = 49
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Complemento:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 29
            Top = 72
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Situa'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 34
            Top = 95
            Width = 40
            Height = 14
            Alignment = taRightJustify
            Caption = 'Usu'#225'rio:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtCodToc: TEditFocus
            Tag = 99
            Left = 77
            Top = 23
            Width = 72
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtCodTocKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesToc: TEditFocus
            Left = 150
            Top = 23
            Width = 300
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtComple: TEditFocus
            Tag = 99
            Left = 77
            Top = 46
            Width = 72
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtCompleKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesComple: TEditFocus
            Left = 150
            Top = 46
            Width = 300
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
          object edtCodSit: TEditFocus
            Tag = 99
            Left = 77
            Top = 69
            Width = 72
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtCodSitKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesSit: TEditFocus
            Left = 150
            Top = 69
            Width = 300
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtCodOpe: TEditFocus
            Tag = 99
            Left = 77
            Top = 92
            Width = 72
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtCodOpeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesOpeOco: TEditFocus
            Left = 150
            Top = 92
            Width = 300
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object mDescricao: TMemoFocus
            Left = 77
            Top = 115
            Width = 373
            Height = 134
            ScrollBars = ssVertical
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 633
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 596
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 669
    Top = 8
  end
  object dtsTabela: TDataSource
    OnStateChange = dtsTabelaStateChange
    Left = 741
    Top = 8
  end
end
