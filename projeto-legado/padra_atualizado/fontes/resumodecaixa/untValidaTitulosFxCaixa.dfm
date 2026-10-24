inherited frmValidaTitulosFxCaixa: TfrmValidaTitulosFxCaixa
  Width = 742
  Height = 382
  BorderIcons = [biSystemMenu]
  Caption = 'T'#237'tulos '#224' vista em aberto'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 742
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 309
    Width = 736
    TabOrder = 1
    ExplicitTop = 309
    ExplicitWidth = 736
    object Label1: TLabel [0]
      Left = 8
      Top = 6
      Width = 283
      Height = 14
      Caption = 'N'#227'o '#233' poss'#237'vel fechar o caixa com t'#237'tulos em aberto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 653
      ExplicitLeft = 653
    end
  end
  object dbgDados: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 736
    Height = 309
    Align = alClient
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = True
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Caption = 'Dta. Cadastro'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DOCUME'
        Title.Caption = 'Documento'
        Width = 125
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Caption = 'Emp.'
        Width = 33
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CLIENT'
        Title.Caption = 'Cliente'
        Width = 303
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Caption = 'Vencimento'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_VALDUP'
        Title.Caption = 'Valor'
        Width = 63
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 337
    Width = 736
    TabOrder = 2
    ExplicitTop = 337
    ExplicitWidth = 736
    inherited pnlNomeForm: TPanel
      Left = 565
      ExplicitLeft = 565
    end
    inherited pnlInfo: TPanel
      Width = 565
      ExplicitWidth = 565
    end
  end
end
