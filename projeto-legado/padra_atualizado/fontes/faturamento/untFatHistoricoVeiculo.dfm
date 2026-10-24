inherited frmFatHistoricoVeiculo: TfrmFatHistoricoVeiculo
  Width = 760
  Height = 402
  BorderIcons = []
  Caption = 'Hist'#243'rico do Ve'#237'culo'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 760
  ExplicitHeight = 402
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 331
    Width = 754
    Height = 26
    ExplicitTop = 331
    ExplicitWidth = 754
    ExplicitHeight = 26
    object Label3: TLabel [0]
      Left = 11
      Top = 6
      Width = 148
      Height = 14
      Caption = 'F10 - Visualizar Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 673
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 750
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 675
      Top = 2
      Align = alRight
      ExplicitLeft = 671
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 754
    Height = 331
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitHeight = 329
    object dbgDocumentos: TDBGridCitel
      Left = 0
      Top = 23
      Width = 754
      Height = 308
      Align = alClient
      DataSource = dtsVeiculo
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DTAENT'
          Title.Caption = 'Data Pedido'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMDOC'
          Title.Caption = 'Documento'
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOCFAT'
          Title.Caption = 'Documento Fat.'
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCLI'
          Title.Caption = 'Cliente'
          Width = 189
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONPAG'
          Title.Caption = 'Condi'#231#227'o de Pagamento'
          Width = 165
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODVEN'
          Title.Caption = 'Vend.'
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Pedido'
          Width = 70
          Visible = True
        end>
    end
    object pnlVeiculo: TPanel
      Left = 0
      Top = 0
      Width = 754
      Height = 23
      Align = alTop
      Caption = 'Placa: AAA-9999 Ve'#237'culo: XXXXXXX'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 357
    Width = 754
    ExplicitTop = 357
    ExplicitWidth = 754
    inherited pnlNomeForm: TPanel
      Left = 583
      ExplicitLeft = 583
    end
    inherited pnlInfo: TPanel
      Width = 583
      ExplicitWidth = 583
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 832
    Top = 140
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 804
    Top = 136
  end
  object dtsVeiculo: TDataSource
    Left = 30
    Top = 70
  end
end
