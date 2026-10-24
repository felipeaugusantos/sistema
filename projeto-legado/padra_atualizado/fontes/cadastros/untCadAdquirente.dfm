inherited frmCadAdquirente: TfrmCadAdquirente
  Height = 188
  Caption = 'Adquirente'
  ExplicitHeight = 188
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 118
    Height = 25
    ExplicitTop = 118
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 507
      Height = 21
      ExplicitTop = 2
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 82
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 164
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 246
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 328
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 410
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 410
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 509
      Width = 74
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 501
      ExplicitWidth = 74
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Height = 118
    ExplicitHeight = 118
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 86
      object Label1: TLabel
        Left = 50
        Top = 14
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 56
        Top = 37
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label3: TLabel
        Left = 52
        Top = 61
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chave:'
      end
      object dbeNomAdq: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 33
        Width = 403
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ADQ_NOMADQ'
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
      object dbeCodAdq: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 10
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ADQ_CODADQ'
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
      object dbeChvReq: TDBEditFocus
        Tag = 99
        Left = 88
        Top = 57
        Width = 403
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ADQ_CHVREQ'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 143
    ExplicitTop = 143
    inherited pnlNomeForm: TPanel
      Left = 398
      Width = 187
      ExplicitLeft = 398
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 398
      ExplicitWidth = 398
    end
  end
  object dtsTabela: TDataSource
    Left = 408
    Top = 16
  end
end
