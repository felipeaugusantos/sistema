inherited frmFatFormulacaoItens: TfrmFatFormulacaoItens
  Left = 0
  Top = 3
  Width = 800
  Height = 557
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Itens referentes ao documento - '
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 486
    Width = 792
    TabOrder = 4
    inherited btnSair: TBitBtn
      Left = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 514
    Width = 792
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      Left = 621
    end
    inherited pnlInfo: TPanel
      Width = 621
    end
  end
  inherited pgcDados: TPageControl
    Width = 792
    Height = 486
    TabOrder = 2
    Visible = False
  end
  object dbgItens: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 792
    Height = 486
    Align = alClient
    DataSource = frmModuloSPR.dtsTemporaria2
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_CODGRU'
        Title.Caption = 'Grupo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_CODITE'
        Title.Caption = 'Item'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESCRI'
        Title.Caption = 'Descri'#231#227'o / Refer'#234'ncia'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_UNIDAD'
        Title.Caption = 'UN'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 70
        Visible = True
      end>
  end
  object pnlBotoesFor: TPanel [4]
    Left = 0
    Top = 486
    Width = 792
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 1
    DesignSize = (
      792
      28)
    object btnCancelarForm: TBitBtn
      Left = 675
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
