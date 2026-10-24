inherited frmCadMetasFatLiq: TfrmCadMetasFatLiq
  Left = 304
  Top = 105
  Width = 750
  Height = 585
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Metas de Vendedores por Faturamento L'#237'quido'
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  ExplicitWidth = 750
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 514
    Width = 744
    Height = 26
    TabOrder = 3
    ExplicitTop = 514
    ExplicitWidth = 744
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 663
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 740
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 120
        ExplicitWidth = 120
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 120
        Width = 120
        ExplicitLeft = 120
        ExplicitWidth = 120
      end
      object btnConfirmar: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 360
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        TabOrder = 3
        OnClick = btnCopiarMetasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 665
      Top = 2
      Align = alRight
      ExplicitLeft = 664
      ExplicitTop = 2
    end
  end
  inherited pnlHeader: TPanel
    Width = 744
    Height = 35
    TabOrder = 0
    ExplicitWidth = 744
    ExplicitHeight = 35
    object Label2: TLabel
      Left = 3
      Top = 10
      Width = 97
      Height = 14
      Caption = 'Per'#237'odo Atual de: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlMesAnoOrigem: TPanel
      Left = 586
      Top = 0
      Width = 158
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      TabStop = True
      Visible = False
      object Label1: TLabel
        Left = 5
        Top = 10
        Width = 95
        Height = 14
        AutoSize = False
        Caption = 'Per'#237'odo de Origem:'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 1
        Height = 35
        Shape = bsLeftLine
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 101
        Top = 6
        Width = 53
        Height = 22
        EditMask = '99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        OnExit = mskDtaOrigemExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 6
      Width = 54
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlTail: TPanel
    Top = 514
    Width = 744
    Height = 0
    TabOrder = 5
    ExplicitTop = 514
    ExplicitWidth = 744
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 75
    Width = 744
    Height = 439
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    OnEnter = dbgConsultaEnter
    Columns = <
      item
        Expanded = False
        FieldName = 'MET_CODVEN'
        ReadOnly = True
        Title.Caption = 'C'#243'd.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMOPE'
        ReadOnly = True
        Title.Caption = 'Nome do Representante'
        Width = 151
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FUNCAO'
        ReadOnly = True
        Title.Caption = 'Fun'#231#227'o'
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBGER'
        ReadOnly = True
        Title.Caption = 'Sub-Gerente'
        Width = 129
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GERENT'
        ReadOnly = True
        Title.Caption = 'Gerente'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_TOTMET'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 87
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 35
    Width = 744
    TabOrder = 1
    ExplicitTop = 35
    ExplicitWidth = 744
    inherited lblPesquisa: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited lblNomeCampo: TLabel
      Top = 12
      ExplicitTop = 12
    end
  end
  inherited pnlStatus: TPanel
    Top = 540
    Width = 744
    TabOrder = 4
    ExplicitTop = 540
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
  inherited mnuAuxiliar: TPopupMenu
    Top = 124
  end
  inherited qryConsulta: TUniQuery
    Top = 123
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 124
  end
  inherited cdsConsulta: TUniClientDataSet
    Top = 124
  end
  inherited dtsConsulta: TDataSource
    Top = 124
  end
end
