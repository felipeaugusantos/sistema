inherited frmDivergenciasSeparacaoColetorUltMov: TfrmDivergenciasSeparacaoColetorUltMov
  Width = 688
  Height = 371
  Caption = #218'ltimas Movimenta'#231#245'es'
  ExplicitWidth = 688
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 288
    Width = 672
    ExplicitTop = 288
    ExplicitWidth = 672
    inherited FlwBotoes: TFlowPanel
      Width = 668
      ExplicitWidth = 668
    end
    inherited btnSair: TBitBtnLocked
      Left = 594
      ExplicitLeft = 594
    end
  end
  inherited pnlStatus: TPanel
    Top = 316
    Width = 672
    ExplicitTop = 316
    ExplicitWidth = 672
    inherited pnlNomeForm: TPanel
      Left = 501
      ExplicitLeft = 501
    end
    inherited pnlInfo: TPanel
      Width = 501
      ExplicitWidth = 501
    end
  end
  inherited pnlHeader: TPanel
    Width = 672
    Height = 27
    ExplicitWidth = 672
    ExplicitHeight = 27
    object lblCodIte: TcxDBLabel
      Left = 6
      Top = 3
      AutoSize = True
      DataBinding.DataField = 'CODITE'
      DataBinding.DataSource = dtsConsulta
    end
    object lblNomIte: TcxDBLabel
      Left = 56
      Top = 3
      AutoSize = True
      DataBinding.DataField = 'NOMITE'
      DataBinding.DataSource = dtsConsulta
    end
  end
  inherited pnlTail: TPanel
    Top = 240
    Width = 672
    ExplicitTop = 240
    ExplicitWidth = 672
  end
  inherited pnlPesquisa: TPanel
    Top = 27
    Width = 672
    Height = 8
    ExplicitTop = 27
    ExplicitWidth = 672
    ExplicitHeight = 8
  end
  inherited dbgConsulta: TcxGridCitel
    Top = 35
    Width = 672
    Height = 205
    ExplicitTop = 35
    ExplicitWidth = 672
    ExplicitHeight = 205
    inherited dbgConsultaDados: TcxGridDBTableViewCitel
      OptionsView.GroupByBox = False
      object dbgConsultaDadosESPDOC: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'ESPDOC'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 37
      end
      object dbgConsultaDadosDTHITE: TcxGridDBColumn
        Caption = 'Data / Hora'
        DataBinding.FieldName = 'DTHENT'
        Options.Editing = False
        Width = 111
      end
      object dbgConsultaDadosQTDITE: TcxGridDBColumn
        Caption = 'Qtde. Mov.'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
      end
      object dbgConsultaDadosNOMOPE: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'NOMOPE'
        Options.Editing = False
        Width = 281
      end
      object dbgConsultaDadosNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Width = 163
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 552
    Top = 88
  end
end
