inherited frmFatFormulacaoGeneric: TfrmFatFormulacaoGeneric
  Left = 410
  Top = 324
  Width = 800
  Height = 500
  Caption = 'Formula'#231#227'o Generic'
  Position = poScreenCenter
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 456
    Width = 794
    ExplicitTop = 456
    ExplicitWidth = 794
    DesignSize = (
      794
      0)
    inherited btnSair: TBitBtnLocked
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 456
    ExplicitWidth = 794
    ExplicitHeight = 456
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 424
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 456
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 64
      Width = 792
      Height = 363
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -16
      TitleFont.Name = 'Courier New'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgFormulacaoKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'TMP_CODITE'
          Title.Caption = 'C'#243'd. Item'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Courier New'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TMP_FORMUL'
          Title.Caption = 'Base / Colorante'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Courier New'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TMP_DESCRI'
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Courier New'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 320
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_QTDBAS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Quantidade'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Courier New'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = [fsBold]
          Width = 190
          Visible = True
        end>
    end
    object pnlBotoesFor: TPanel
      Left = 1
      Top = 427
      Width = 792
      Height = 28
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        792
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
        Left = 678
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 3
        Top = 3
        Width = 149
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Imprimir Formula'#231#227'o'
        TabOrder = 0
        OnClick = btnImprimirClick
      end
    end
    object mmoBase: TMemo
      Left = 1
      Top = 1
      Width = 792
      Height = 63
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 456
    Width = 794
    ExplicitTop = 456
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 646
      Width = 148
      ExplicitLeft = 646
      ExplicitWidth = 148
    end
    inherited pnlInfo: TPanel
      Width = 646
      ExplicitWidth = 646
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 16
  end
end
