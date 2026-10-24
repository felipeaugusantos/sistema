inherited frmFatFormulacaoLazzumix: TfrmFatFormulacaoLazzumix
  Left = 410
  Top = 324
  Width = 362
  Height = 315
  ActiveControl = nil
  Caption = 'Formula'#231#227'o Lazzumix'
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 272
    Width = 354
    inherited btnSair: TBitBtn
      Left = 235
    end
  end
  inherited pnlStatus: TPanel
    Top = 272
    Width = 354
    inherited pnlNomeForm: TPanel
      Left = 206
      Width = 148
    end
    inherited pnlInfo: TPanel
      Width = 206
    end
  end
  inherited pgcDados: TPageControl
    Width = 354
    Height = 272
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 354
    Height = 272
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 1
      Width = 352
      Height = 242
      Align = alClient
      DataSource = frmModuloSPR.dtsTemporaria3
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgFormulacaoKeyDown
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
      Top = 243
      Width = 352
      Height = 28
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        352
        28)
      object btnCancelarForm: TBitBtn
        Left = 231
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 0
        OnClick = btnCancelarFormClick
      end
    end
  end
end
