inherited frmGeraCredCliente: TfrmGeraCredCliente
  Left = 410
  Top = 314
  Width = 750
  Height = 453
  ActiveControl = dbgCredito
  BorderIcons = [biSystemMenu]
  Caption = 'Cr'#233'dito do Cliente'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 750
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 381
    Width = 744
    ExplicitTop = 381
    ExplicitWidth = 744
    DesignSize = (
      744
      28)
    inherited btnSair: TBitBtnLocked
      Left = 661
      ExplicitLeft = 661
    end
    object btnConfirmar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 128
      Height = 22
      Caption = '[ F10 ] Confirmar Cr'#233'dito'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 409
    Width = 744
    ExplicitTop = 409
    ExplicitWidth = 744
    inherited pnlNomeForm: TPanel
      Left = 573
      ExplicitLeft = 573
    end
    inherited pnlInfo: TPanel
      Width = 573
      ExplicitWidth = 573
    end
  end
  object dbgCredito: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 744
    Height = 356
    Align = alClient
    DataSource = dtsCredito
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgCreditoKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'MARCA'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAINI'
        Title.Alignment = taCenter
        Title.Caption = 'Dt. Inicial'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAFIN'
        Title.Alignment = taCenter
        Title.Caption = 'Dt. Final'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPMET'
        Title.Alignment = taCenter
        Title.Caption = 'V/L'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 20
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'META'
        Title.Alignment = taRightJustify
        Title.Caption = 'Meta'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LITRAGEM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Litros/Kilos'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FATURA'
        Title.Alignment = taRightJustify
        Title.Caption = 'Faturamento'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCON'
        Title.Alignment = taRightJustify
        Title.Caption = '% Desc.'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALC_CREDITO'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cr'#233'dito'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTABAI'
        Title.Alignment = taCenter
        Title.Caption = 'Dt. Cr'#233'dito'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Pitch = fpVariable
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end>
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 356
    Width = 744
    Height = 25
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbtxtDESMAR: TDBText
      Left = 8
      Top = 5
      Width = 573
      Height = 15
      DataField = 'MARCA'
      DataSource = dtsCredito
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 56
  end
  object cdsCredito: TUniClientDataSet
    Aggregates = <>
    Params = <>
    OnCalcFields = cdsCreditoCalcFields
    Left = 598
    Top = 56
    object cdsCreditoMARCA: TStringField
      FieldName = 'MARCA'
      Size = 200
    end
    object cdsCreditoDTAINI: TDateTimeField
      FieldName = 'DTAINI'
    end
    object cdsCreditoDTAFIN: TDateTimeField
      FieldName = 'DTAFIN'
    end
    object cdsCreditoMETA: TFloatField
      FieldName = 'META'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsCreditoFATURA: TFloatField
      FieldName = 'FATURA'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsCreditoDESCON: TFloatField
      FieldName = 'DESCON'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsCreditoLITRAGEM: TFloatField
      FieldName = 'LITRAGEM'
      DisplayFormat = '#,##0.00'
    end
    object cdsCreditoCALC_CREDITO: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CALC_CREDITO'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
      Calculated = True
    end
    object cdsCreditoDTABAI: TDateTimeField
      FieldName = 'DTABAI'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = 'dd/mm/yyyy'
    end
    object cdsCreditoGRUPO: TStringField
      FieldName = 'GRUPO'
      Size = 70
    end
    object cdsCreditoFORNEC: TStringField
      FieldName = 'FORNEC'
      Size = 60
    end
    object cdsCreditoTIPMET: TStringField
      FieldName = 'TIPMET'
      Size = 1
    end
  end
  object dtsCredito: TDataSource
    DataSet = cdsCredito
    OnDataChange = dtsCreditoDataChange
    Left = 628
    Top = 56
  end
end
