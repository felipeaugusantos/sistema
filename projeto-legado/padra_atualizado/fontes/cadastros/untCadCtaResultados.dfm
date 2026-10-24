inherited frmCadCtaResultados: TfrmCadCtaResultados
  Left = 394
  Top = 297
  Width = 536
  Caption = 'Cadastro de Contas de Resultado'
  OnDestroy = FormDestroy
  ExplicitWidth = 536
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 261
    Width = 530
    Height = 25
    TabOrder = 1
    ExplicitTop = 261
    ExplicitWidth = 530
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 454
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 454
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 456
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 456
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Width = 530
    TabOrder = 3
    ExplicitWidth = 530
    inherited pnlNomeForm: TPanel
      Left = 358
      Width = 172
      ExplicitLeft = 358
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 358
      ExplicitWidth = 358
    end
  end
  inherited pgcDados: TPageControl
    Width = 530
    Height = 261
    Visible = False
    ExplicitWidth = 530
    ExplicitHeight = 261
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 522
      ExplicitHeight = 229
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 530
    Height = 261
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 51
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 35
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object pnlGrid: TPanel
      Left = 2
      Top = 82
      Width = 526
      Height = 177
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object dbgDesCta: TDBGridCitel
        Left = 2
        Top = 2
        Width = 522
        Height = 173
        Align = alClient
        DataSource = dtsConsulta
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgDesCtaKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CTA_CODCTA'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CTA_DESCTA'
            Title.Caption = 'Descri'#231#227'o'
            Width = 400
            Visible = True
          end>
      end
    end
    object dbeCodCre: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 9
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CRE_CODCRE'
      DataSource = dtsCtaRes
      TabOrder = 1
      OnExit = dbeCodCreExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDesCre: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 31
      Width = 412
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CRE_DESCRE'
      DataSource = dtsCtaRes
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = -2
      Top = 53
      Width = 504
      Height = 22
      TabOrder = 3
      ExplicitLeft = -2
      ExplicitTop = 53
      ExplicitWidth = 504
      inherited lblPlaContas: TLabel
        Left = 11
        Width = 81
        Height = 14
        ExplicitLeft = 11
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 155
        Width = 349
        Height = 22
        Visible = False
        ExplicitLeft = 155
        ExplicitWidth = 349
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 92
        Width = 62
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 92
        ExplicitWidth = 62
        ExplicitHeight = 22
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 584
    Top = 336
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 144
    Top = 144
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 176
    Top = 144
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 208
    Top = 144
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 240
    Top = 144
  end
  object dtsCtaRes: TDataSource
    Left = 304
    Top = 144
  end
end
