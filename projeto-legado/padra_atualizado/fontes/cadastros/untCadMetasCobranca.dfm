inherited frmCadMetasCobranca: TfrmCadMetasCobranca
  Width = 785
  Height = 489
  Caption = 'Cadastro de Metas de Cobran'#231'a de T'#237'tulos em Atraso'
  ExplicitWidth = 785
  ExplicitHeight = 489
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 406
    Width = 769
    ExplicitTop = 406
    ExplicitWidth = 769
    inherited FlwBotoes: TFlowPanel
      Width = 765
      ExplicitWidth = 765
      object btnConfirmar: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 359
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        TabOrder = 3
        OnClick = btnCopiarMetasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 691
      ExplicitLeft = 691
    end
  end
  inherited pnlHeader: TPanel
    Width = 769
    ExplicitWidth = 769
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 769
      Height = 41
      Align = alTop
      BevelOuter = bvLowered
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object Label2: TLabel
        Left = 3
        Top = 14
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
      object Label3: TLabel
        Left = 161
        Top = 14
        Width = 55
        Height = 14
        Caption = 'Empresa: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object shpCodEmp: TShape
        Left = 218
        Top = 9
        Width = 5
        Height = 22
        Brush.Color = clGreen
      end
      object edtNomEmp: TEditFocus
        Tag = 99
        Left = 268
        Top = 9
        Width = 222
        Height = 22
        Alignment = taLeftJustify
        Enabled = False
        MaxLength = 3
        TabOrder = 2
        OnKeyPress = edtNomEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object pnlMesAnoOrigem: TPanel
        Left = 495
        Top = 1
        Width = 273
        Height = 39
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
        TabOrder = 3
        TabStop = True
        Visible = False
        object Panel2: TPanel
          Left = 8
          Top = 5
          Width = 249
          Height = 29
          ShowCaption = False
          TabOrder = 0
          object Bevel1: TBevel
            Left = 0
            Top = 0
            Width = 1
            Height = 35
            Shape = bsLeftLine
          end
          object Label1: TLabel
            Left = -7
            Top = 8
            Width = 188
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Copiar metas do Per'#237'odo de Origem:'
          end
          object mskDtaOrigem: TMaskEditFocus
            Tag = 99
            Left = 188
            Top = 3
            Width = 53
            Height = 22
            EditMask = '99/9999'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 7
            TabOrder = 0
            Text = '  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
        end
      end
      object mskDtaAtual: TMaskEditFocus
        Tag = 99
        Left = 102
        Top = 9
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
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 224
        Top = 9
        Width = 43
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 1
        OnExit = edtCodEmpExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 358
    Width = 769
    ExplicitTop = 358
    ExplicitWidth = 769
  end
  inherited dbgConsulta: TDBGridCitel
    Width = 769
    Height = 261
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ParentCtl3D = False
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'MET_CODOPE'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        Title.Caption = 'Operador'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_METREC'
        Title.Caption = 'Meta de Recebimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_COMNAO'
        Title.Caption = '%Comiss'#227'o Meta N'#227'o Atingida'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_COMSIM'
        Title.Caption = '%Comiss'#227'o Meta Atingida'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Width = 769
    ExplicitWidth = 769
    inherited lblPesquisa: TLabel
      Top = 8
      ExplicitTop = 8
    end
    inherited lblNomeCampo: TLabel
      Top = 9
      ExplicitTop = 9
    end
  end
  inherited pnlStatus: TPanel
    Top = 434
    Width = 769
    ExplicitTop = 434
    ExplicitWidth = 769
    inherited pnlNomeForm: TPanel
      Left = 598
      ExplicitLeft = 598
    end
    inherited pnlInfo: TPanel
      Width = 598
      ExplicitWidth = 598
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 144
  end
  inherited qryConsulta: TUniQuery
    Left = 72
    Top = 176
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 144
    Top = 200
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 312
    Top = 280
    object cdsConsultaMET_CODOPE: TStringField
      FieldName = 'MET_CODOPE'
      Size = 3
    end
    object cdsConsultaOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      Size = 30
    end
    object cdsConsultaMET_METREC: TFloatField
      FieldName = 'MET_METREC'
    end
    object cdsConsultaMET_COMSIM: TFloatField
      FieldName = 'MET_COMSIM'
    end
    object cdsConsultaMET_COMNAO: TFloatField
      FieldName = 'MET_COMNAO'
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 232
    Top = 280
  end
end
