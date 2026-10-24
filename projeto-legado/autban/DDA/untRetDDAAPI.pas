unit untRetDDAAPI;

interface
{$WARN UNIT_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.FileCtrl, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Data.DB, Datasnap.DBClient,
  UniClientDataSet, frxDBSet, untTPagFor, untFuncoes, untFuncoesSimples,
  untFrameDirectoryEditFocus, cxProgressBar, System.DateUtils,
  untDDAAPIRetDDAFrame, untTiposDDA, Uni;

type
  TfrmRetDDAAPI = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    frxDBNaoGra: TfrxDBDataset;
    cdsNaoGra: TUniClientDataSet;
    cdsNaoGraDTAVEN: TDateField;
    cdsNaoGraCODEMP: TStringField;
    cdsNaoGraESPDOC: TStringField;
    cdsNaoGraNUMDUP: TStringField;
    cdsNaoGraCNPJ__: TStringField;
    cdsNaoGraNOMCED: TStringField;
    cdsNaoGraCODBAR: TStringField;
    cdsNaoGraDTAEMI: TDateField;
    cdsNaoGraVALTIT: TFloatField;
    cdsNaoGraAGECOB: TStringField;
    cdsNaoGraCODAGE: TStringField;
    cdsNaoGraCODCTA: TStringField;
    cdsNaoGraCODBCO: TStringField;
    cdsNaoGraDTAARQ: TDateTimeField;
    cdsNaoGraCNPCPF: TStringField;
    cdsNaoGraCODMOV: TStringField;
    cdsNaoGraVALBAR: TFloatField;
    cdsNaoGraBCOCOM: TStringField;
    cdsNaoGraMODCAR: TStringField;
    cdsNaoGraCODLOT: TStringField;
    cdsNaoGraDIGCBR: TStringField;
    cdsNaoGraFATVEN: TStringField;
    cdsNaoGraCODMOE: TStringField;
    cdsNaoGraCAMLIV: TStringField;
    cdsNaoGraCODFOR: TStringField;
    cdsNaoGraLINDIG: TStringField;
    cdsNaoGraDUPCOR: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
   private
    FImportacaoAPI: Boolean;
    FObjetoImportacao: TObject;
    FFrameDDA : TfraDDAAPIRetDDAFrame;
    FCodBanco : string;
    FConfiguracao : string;

    procedure pAtualizaHist;

    { Private declarations }
  public

    procedure AjustarAoTamanhoDoFrame;

    property ImportacaoAPI: Boolean read FImportacaoAPI write FImportacaoAPI;
    property CodBanco: string read FCodBanco write FCodBanco;
    property Configuracao: string read FConfiguracao write FConfiguracao;
    { Public declarations }
  end;

var
  frmRetDDA: TfrmRetDDAAPI;

implementation

Uses untTImportaDDA, untTDDASicoobAPI;

{$R *.dfm}

procedure TfrmRetDDAAPI.AjustarAoTamanhoDoFrame;
var
  LLarguraFrame, AlturaFrame          : Integer;
  LAlinhamentoAnterior                : TAlign;
  LAlturaPainelRodapes                : Integer;
  LIndiceControle                     : Integer;
  LLarguraBordaNaoCliente             : Integer;
  LAlturaBordaNaoCliente              : Integer;
begin
  if not Assigned(FFrameDDA) then
    Exit;

  FFrameDDA.AutoSize := True;
  Realign;

  LAlinhamentoAnterior := FFrameDDA.Align;
  FFrameDDA.Align := alNone;
  try
    LLarguraFrame := FFrameDDA.Width;
    AlturaFrame  := FFrameDDA.Height;
  finally
    FFrameDDA.Align := LAlinhamentoAnterior;
  end;

  LAlturaPainelRodapes := 0;
  for LIndiceControle := 0 to Pred(ControlCount) do
    if Controls[LIndiceControle].Visible and (Controls[LIndiceControle].Align = alBottom) then
      Inc(LAlturaPainelRodapes, Controls[LIndiceControle].Height);

  ClientWidth  := LLarguraFrame + FFrameDDA.Margins.Left + FFrameDDA.Margins.Right;
  ClientHeight := FFrameDDA.Top + AlturaFrame + LAlturaPainelRodapes;

  LLarguraBordaNaoCliente := Width  - ClientWidth;
  LAlturaBordaNaoCliente  := Height - ClientHeight;

  Constraints.MinWidth  := ClientWidth  + LLarguraBordaNaoCliente;
  Constraints.MinHeight := ClientHeight + LAlturaBordaNaoCliente;
end;

procedure TfrmRetDDAAPI.btnGravarClick(Sender: TObject);
var
  LImportadorDDA: TImportaDDA;
begin
  inherited;

  if not FFrameDDA.ValidarDados then
    Exit;

  try
    case StrToInt(FCodBanco) of
      756:
        begin
          if not cdsNaoGra.Active then
            cdsNaoGra.CreateDataSet
          else
            cdsNaoGra.EmptyDataSet;

          TDDASicoobAPI(FObjetoImportacao).ImportarMovimentacoesDDA(
            FFrameDDA.edtDataInicial.Date,
            FFrameDDA.edtDataFinal.Date,
            FFrameDDA.Situacao,
            FFrameDDA.TipoData,
            cdsNaoGra,
            nil
          );

          if cdsNaoGra.IsEmpty then
          begin
            fMensagem('INFORMAÇÃO', 'Nenhuma movimentação DDA retornada no período.', ['&OK']);
            Exit;
          end;

          LImportadorDDA := TImportaDDA.Create;

          pAtualizaHist;

          try
            if not LImportadorDDA.fImportaDDA(cdsNaoGra, FCodBanco) then
              raise Exception.Create('Falha ao gravar as movimentações DDA no RETDDA.');
          finally
            LImportadorDDA.Free;
          end;

          fMensagem('INFORMAÇÃO', 'Importação DDA (API) concluída com sucesso.', ['&OK']);
        end;
    else
      fMensagem('ATENÇÃO', 'Banco não configurado para importação DDA Online.', ['&OK']);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TfrmRetDDAAPI.btnGravarClick]');
  end;
end;

procedure TfrmRetDDAAPI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FObjetoImportacao) then
    FreeAndNil(FObjetoImportacao);
end;

procedure TfrmRetDDAAPI.FormCreate(Sender: TObject);
begin
  inherited;
  FImportacaoAPI := True;

  FFrameDDA := TfraDDAAPIRetDDAFrame.Create(Self);
  FFrameDDA.Parent := Self;
  FFrameDDA.AlignWithMargins := True;
  FFrameDDA.Margins.SetBounds(8,8,8,8);
  FFrameDDA.AutoSize := True;
  FFrameDDA.Align := alTop;
  FFrameDDA.Visible := True;
end;

procedure TfrmRetDDAAPI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) then
    btnSair.Click;

  if (Key = VK_RETURN) then
    Key := VK_TAB;
end;

procedure TfrmRetDDAAPI.FormShow(Sender: TObject);
var
  LDados: TDDAAPIDadosCarteira;
begin
  inherited;

  FFrameDDA.edtDataInicial.Date := IncDay(VS_Date, -5);
  FFrameDDA.edtDataFinal.Date   := VS_Date;

  case StrToInt(FCodBanco) of
    756:
      begin
        FObjetoImportacao := TDDASicoobAPI.Create(FConfiguracao + '-' + VS_strCodEmp);

        LDados := TDDAAPIDadosCarteira.Create(FCodBanco, FConfiguracao + '-' + VS_strCodEmp);
        try
          FFrameDDA.CarregarDadosCarteira(LDados);
        finally
          LDados.Free;
        end;
      end;
  end;
  AjustarAoTamanhoDoFrame;
end;

procedure TfrmRetDDAAPI.pAtualizaHist;
var
  LStrSQL: string;
  LQryUpdHIS: TUniQuery;
begin
  Try
    LStrSQL := '';
    LStrSQL := LStrSQL + 'UPDATE                                              ';
    LStrSQL := LStrSQL + '  RETDDA                                            ';
    LStrSQL := LStrSQL + '  LEFT JOIN CADPAG                                  ';
    LStrSQL := LStrSQL + '    ON AUTOINCREM = DDA_AUTCTP                      ';
    LStrSQL := LStrSQL + '  LEFT JOIN CADFOR A                                ';
    LStrSQL := LStrSQL + '    ON A.FOR_CODFOR = DDA_CODFOR                    ';
    LStrSQL := LStrSQL + '  LEFT JOIN CADFOR B                                ';
    LStrSQL := LStrSQL + '    ON B.FOR_CODFOR = CTP_CODFOR                    ';
    LStrSQL := LStrSQL + ' SET                                                ';
    LStrSQL := LStrSQL + '   DDA_HIST01 = "DUPLICATA IMPORTADA - DDA ONLINE"  ';
    LStrSQL := LStrSQL + 'WHERE DDA_HIST01 IS NULL                            ';
    LStrSQL := LStrSQL + '  AND (                                             ';
    LStrSQL := LStrSQL + '    A.FOR_CODFOR IS NOT NULL                        ';
    LStrSQL := LStrSQL + '    OR B.FOR_CODFOR IS NOT NULL                     ';
    LStrSQL := LStrSQL + '  )                                                 ';


    LQryUpdHIS := fCriaQuery(Nil);

    LQryUpdHIS.Close;
    LQryUpdHIS.SQL.Clear;
    LQryUpdHIS.SQL.Add(LStrSQL);
    LQryUpdHIS.ExecSQL;

  except
    on E: Exception do
    begin
      pMensagensErro(E.Message, 'TfrmRetDDAAPI.pAtualizaHist');
    end;
  end;

  LQryUpdHIS.Close;
  FreeAndNil(LQryUpdHIS);
end;

end.
