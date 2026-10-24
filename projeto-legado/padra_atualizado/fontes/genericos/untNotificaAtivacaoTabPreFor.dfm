inherited frmNotificaAtivacaoTabPreFor: TfrmNotificaAtivacaoTabPreFor
  Width = 792
  Height = 326
  Caption = 'Ativa'#231#227'o de Tabela de Pre'#231'os de Fornecedores'
  Position = poMainFormCenter
  ExplicitWidth = 792
  ExplicitHeight = 326
  PixelsPerInch = 96
  TextHeight = 14
  object lblMensagemTopo: TLabel [0]
    Left = 0
    Top = 0
    Width = 786
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Existem tabelas de pre'#231'os na rotina de ( Fornecedores - Forma'#231#227'o' +
      ' de Pre'#231'os ) para serem efetivadas.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object lblMensagemButtom: TLabel [1]
    Left = 0
    Top = 204
    Width = 786
    Height = 51
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    BiDiMode = bdLeftToRight
    Caption = 
      'Para efetiv'#225'-las, acessar UTIL -> OPERA'#199#213'ES REFERENTE A PRODUTOS' +
      ' -> ALTERA'#199#195'O GLOBAL DE PRE'#199'OS -> ATIVA'#199#195'O DE CUSTOS POR FORNECE' +
      'DOR DOS PRODUTOS.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ExplicitTop = 200
  end
  inherited pnlBotoes: TPanel
    Top = 255
    Width = 786
    Height = 26
    ExplicitTop = 255
    ExplicitWidth = 786
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 705
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 782
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 707
      Top = 2
      Align = alRight
      ExplicitLeft = 703
    end
  end
  object dbgDados: TDBGridCitel [4]
    Tag = 99
    Left = 0
    Top = 30
    Width = 786
    Height = 174
    Align = alClient
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDadosDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'TAB_CODTAB'
        Title.Caption = 'C'#243'd. Tab.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAB_NOMTAB'
        Title.Caption = 'Descri'#231#227'o'
        Width = 274
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORNEC'
        Title.Caption = 'Fornecedor'
        Width = 296
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAB_DTAEFE'
        Title.Caption = 'Dta. Efetiva'#231#227'o'
        Width = 94
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 281
    Width = 786
    ExplicitTop = 281
    ExplicitWidth = 786
    inherited pnlNomeForm: TPanel
      Left = 615
      ExplicitLeft = 615
    end
    inherited pnlInfo: TPanel
      Width = 615
      ExplicitWidth = 615
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
    Top = 96
  end
end
