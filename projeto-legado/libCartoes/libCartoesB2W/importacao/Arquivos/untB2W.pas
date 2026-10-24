{*********************************}
{* Importação de arquivos do B2W *}
{******************************AJ*}
unit untB2W;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
     WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils, System.SysUtils,

     Uni, cxProgressBar,

     untIB2WIntegracaoLibCartoes, untTB2WImportacaoCartao,
     untB2WPgto, untTB2WFuncoes;

Type
  TB2W =  Class(TB2WImportacaoCartao)

    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure ProcessaArquivosSelecionados(AArquivos: TStringList; var prgStatus: TcxProgressBar); override;
    procedure CarregaArquivosSelecionados(AAquivos: TStringList);
  private
    objPgto: ICartoesB2W;

    procedure pAdiciona(itrCartoes: ICartoesB2W; stlArqs: TStringList);
  public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  end;

implementation

{ TB2W }

constructor TB2W.Create(Owner: TComponent);
begin
  inherited;
  objPgto   := TB2WPgto.Create;
  strNomCon := 'B2W';
  strMenCon := '';
end;

destructor TB2W.Destroy;
begin
  TB2WFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

  If Assigned(VS_DatasPagamento) Then
    FreeAndNil(VS_DatasPagamento);

  objPgto := Nil;

  SetLength(FRegB2WPgto, 0);
  inherited;
end;

procedure TB2W.pAdiciona(itrCartoes: ICartoesB2W; stlArqs: TStringList);
Var
  intCont  : Integer;
  intLin   : Integer;
  stlAux   : TStringList;
  dtaDtaArq: TDateTimeInfoRec;
  LModeloImportacao : Integer;
begin
  stlAux := Nil;
  Try
    stlAux := TStringList.Create;

    For intCont := 0 To stlArqs.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(stlArqs[intCont]);
      untB2WPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
      FileGetDateTimeInfo(stlArqs[intCont], dtaDtaArq);
      untB2WPgto.strDtaArq := FormatDateTime('dd/mm/yyyy', dtaDtaArq.CreationTime);

      LModeloImportacao := TB2WPgto(itrCartoes).fRetornaTipoModeloImportacao(stlAux[0]);
      TB2WPgto(itrCartoes).pDefineModeloImportacao(LModeloImportacao);
      For intLin := 0 To stlAux.Count -1 Do
        itrCartoes.pAdicionaLinha(stlAux[intLin]);

      stlAux.Clear;
    End;
  Finally
    TB2WFuncoes.FreeAndNilStringLists(stlAux);
  End;
end;

procedure TB2W.pAdicionaLinhas;
Begin
  inherited;
  Try
    SetLength(FRegB2WPgto , 0);

    pAdiciona(objPgto,FArquivos);
  Except
    Raise;
  End;
end;

procedure TB2W.CarregaArquivosSelecionados(AAquivos: TStringList);
Var
    LContador: Integer;
    LArquivo: TextFile;
    LLinhaArquivo,
    LNomeArquivo : string;
begin
  Try
    For LContador := 0 to AAquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName(AAquivos[LContador]);

      Application.ProcessMessages;
      AssignFile(LArquivo, AAquivos[LContador]);
      Try
        Reset(LArquivo);
        Readln(LArquivo, LLinhaArquivo);
        LLinhaArquivo := TB2WFuncoes.fConverteParaAcento(LLinhaArquivo);

        If (Pos('"Marca";"Nome Fantasia";"Data pedido";"Data Pagamento";"Data Estorno";', LLinhaArquivo) > 0) Then
          FArquivos.Add(AAquivos[LContador]);

        If (Pos('Marketplace;Seller;Data de Criação do Lançamento;Pedido;Pedido Site;Status do Pedido;', LLinhaArquivo) > 0) Then
          FArquivos.Add(AAquivos[LContador]);
      Finally
        Flush(LArquivo);
        Close(LArquivo);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      If Pos('I/O', E.Message) > 0 Then
        TB2WFuncoes.fMensagem('ATENÇÃO', 'O arquivo ' + LNomeArquivo + ' está aberto em outro aplicativo.' + #13 +
                                           'Operação cancelada!', ['&OK'])
      Else
         TB2WFuncoes.fMensagem('ATENÇÃO', 'Ocorreu um erro: ' + E.Message, ['&OK']);

      frmImportacaoCartoes.Close;
      Exit;
    End;
  End;
end;

procedure TB2W.pGravarRegistros;
Var
  intCont: Integer;
begin
  inherited;
  VS_FuncoesExternas.fIStartTransaction;
  Try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivos.Count - 1 do
    Begin
      If (FileExists(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'))) Then
        DeleteFile(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
      TB2WFuncoes.pRenomeiaAquivo(FArquivos[intCont], AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;

      TB2WFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

procedure TB2W.ProcessaArquivosSelecionados(AArquivos: TStringList;
  var prgStatus: TcxProgressBar);
begin
   Try
    SetLength(FRegB2WPgto, 0);

    CarregaArquivosSelecionados(AArquivos);
    If (FArquivos.Count  = 0) Then
    Begin
      Tb2wFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    VS_CodigoEmpresa := edtCodigoEmpresa.Text;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    Tb2wFuncoes.fMensagem('', 'Dados importados com sucesso!', ['&OK']);
  Except
    On E: Exception Do
      Tb2wFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);
  End;

  frmImportacaoCartoes.Close;

end;

end.
