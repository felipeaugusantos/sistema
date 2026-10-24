inherited frmFatFormulacaoAnnetta: TfrmFatFormulacaoAnnetta
  Left = 410
  Top = 324
  Width = 420
  Height = 315
  Caption = 'Formula'#231#227'o Annetta'
  Position = poScreenCenter
  ExplicitWidth = 420
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 274
    Width = 414
    ExplicitTop = 271
    ExplicitWidth = 414
    DesignSize = (
      414
      0)
    inherited btnSair: TBitBtnLocked
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited pnlStatus: TPanel
    Top = 274
    Width = 414
    ExplicitTop = 271
    ExplicitWidth = 414
    inherited pnlNomeForm: TPanel
      Left = 266
      Width = 148
      ExplicitLeft = 266
      ExplicitWidth = 148
    end
    inherited pnlInfo: TPanel
      Width = 266
      ExplicitWidth = 266
    end
  end
  inherited pgcDados: TPageControl
    Top = 63
    Width = 414
    Height = 211
    ExplicitTop = 63
    ExplicitWidth = 414
    ExplicitHeight = 208
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 406
      ExplicitHeight = 176
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 63
    Width = 414
    Height = 211
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 208
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 1
      Width = 412
      Height = 178
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgFormulacaoKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'TMP_FORMUL'
          Title.Caption = 'Formula'#231#227'o'
          Width = 250
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_QTDBAS'
          Title.Caption = 'Quantidade'
          Width = 70
          Visible = True
        end>
    end
    object pnlBotoesFor: TPanel
      Left = 1
      Top = 179
      Width = 412
      Height = 28
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        412
        28)
      object lblTipoFormulacao: TLabel
        Left = 154
        Top = 8
        Width = 130
        Height = 15
        Caption = 'Formula'#231#227'o em Pulsos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnCancelarForm: TBitBtnLocked
        Left = 295
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 4
        Top = 4
        Width = 149
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Etiqueta Formula'#231#227'o'
        TabOrder = 0
        OnClick = btnImprimirClick
      end
    end
  end
  object memBase: TMemo [4]
    Left = 0
    Top = 0
    Width = 414
    Height = 63
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
