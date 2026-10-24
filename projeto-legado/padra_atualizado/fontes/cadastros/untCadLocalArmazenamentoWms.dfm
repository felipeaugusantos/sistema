inherited frmCadLocalArmazenamentoWms: TfrmCadLocalArmazenamentoWms
  Left = 254
  Top = 376
  Width = 573
  Height = 210
  Caption = 'Cadastro de local de armazenamento - WMS'
  ExplicitWidth = 573
  ExplicitHeight = 210
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 137
    Width = 567
    TabOrder = 1
    ExplicitTop = 133
    ExplicitWidth = 567
    DesignSize = (
      567
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 563
      ExplicitTop = 2
      ExplicitWidth = 563
    end
    inherited btnSair: TBitBtnLocked
      Left = 482
      Width = 72
      Height = 20
      ExplicitLeft = 482
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 165
    Width = 567
    TabOrder = 3
    ExplicitTop = 161
    ExplicitWidth = 567
    inherited pnlNomeForm: TPanel
      Left = 400
      Width = 167
      ExplicitLeft = 400
      ExplicitWidth = 167
    end
    inherited pnlInfo: TPanel
      Width = 400
      ExplicitWidth = 400
    end
  end
  inherited pgcDados: TPageControl
    Width = 567
    Height = 137
    Visible = False
    ExplicitWidth = 567
    ExplicitHeight = 133
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 559
      ExplicitHeight = 101
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 567
    Height = 137
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 133
    object pnlLocFis: TPanel
      Left = 2
      Top = 53
      Width = 563
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      Visible = False
      object lblLocFis: TLabel
        Left = 45
        Top = 5
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Loc. F'#237'sica:'
      end
      object edtLocFis: TEditFocus
        Tag = 99
        Left = 101
        Top = 2
        Width = 134
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 0
        OnKeyPress = edtLocFisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesLoc: TEditFocus
        Left = 236
        Top = 2
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
    end
    object pnlTop: TPanel
      Left = 2
      Top = 2
      Width = 563
      Height = 51
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 63
        Top = 6
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 47
        Top = 31
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodLar: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 3
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LAR_CODLAR'
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
      object dbeDesLar: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 28
        Width = 420
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LAR_DESLAR'
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
    end
    object pnlPonImp: TPanel
      Left = 2
      Top = 78
      Width = 563
      Height = 51
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      Visible = False
      object Label3: TLabel
        Left = 17
        Top = -2
        Width = 82
        Height = 28
        Alignment = taRightJustify
        Caption = 'Ponto de Imp. da DANFE:'
        WordWrap = True
      end
      object Label4: TLabel
        Left = 9
        Top = 24
        Width = 90
        Height = 28
        Alignment = taRightJustify
        Caption = 'Ponto de Imp. da Etiq. de Despacho:'
        WordWrap = True
      end
      object edtPonNFe: TEditFocus
        Tag = 99
        Left = 101
        Top = 2
        Width = 134
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 0
        OnKeyPress = edtPonNFeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesPonNFe: TEditFocus
        Left = 236
        Top = 2
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
      object edtPonEtd: TEditFocus
        Tag = 99
        Left = 101
        Top = 27
        Width = 134
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 2
        OnKeyPress = edtPonEtdKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesPonEtd: TEditFocus
        Left = 236
        Top = 27
        Width = 285
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 352
  end
end
