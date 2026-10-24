inherited frmCadMotivosAproveitamentoItens: TfrmCadMotivosAproveitamentoItens
  Height = 114
  Caption = 'Motivos para Aproveitamento de Itens'
  OnDestroy = FormDestroy
  ExplicitHeight = 114
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 41
    ExplicitTop = 41
  end
  inherited pnlStatus: TPanel
    Top = 69
    ExplicitTop = 69
  end
  inherited pgcDados: TPageControl
    Width = 5
    Height = 5
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitWidth = 5
    ExplicitHeight = 5
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitTop = 6
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 41
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDados'
    ShowCaption = False
    TabOrder = 3
    object Label2: TLabel
      Left = 357
      Top = 16
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 162
      Top = 17
      Width = 23
      Height = 14
      Caption = 'Tipo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 411
      Top = 12
      Width = 170
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MAI_DESCRI'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 13
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MAI_CODIGO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbcbTIPMOT: TDBComboBoxFocus
      Tag = 99
      Left = 189
      Top = 12
      Width = 164
      Height = 22
      DataField = 'MAI_TIPMOT'
      Items.Strings = (
        'Origem'
        'Motivo'
        'Destino')
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 112
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 0
  end
end
